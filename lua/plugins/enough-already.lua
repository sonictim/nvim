local M = {}
local ns_id = vim.api.nvim_create_namespace('comment_visibility')
local state = {
	buffers = {} -- Per-buffer state
}

-- Comment patterns for different languages
local comment_patterns = {
	lua = { line = "%-%-", block_start = "%-%-(%[=*%[)", block_end = "%]=*%]" },
	javascript = { line = "//", block_start = "/%*", block_end = "%*/" },
	rust = { line = "//", block_start = "/%*", block_end = "%*/" },
	python = { line = "#" },
	-- Add more...
}

local function get_buf_state(bufnr)
	if not state.buffers[bufnr] then
		state.buffers[bufnr] = {
			hidden = false,
			comment_data = {}, -- Store comment content and extmark info
			signs = {}
		}
	end
	return state.buffers[bufnr]
end

local function is_comment_only_line(line, patterns)
	local content = line:match("^%s*(.-)%s*$")
	if patterns.line then
		return content:match("^" .. patterns.line) ~= nil
	end
	return false
end

local function get_inline_comment_pos(line, patterns)
	if patterns.line then
		-- Find the actual comment start position
		local start_pos = line:find(patterns.line)
		return start_pos
	end
	return nil
end

local function has_inline_comment(line, patterns)
	if patterns.line then
		local comment_pos = line:find(patterns.line)
		if comment_pos and comment_pos > 1 then
			-- Make sure there's actual code before the comment
			local code_part = line:sub(1, comment_pos - 1):match("^%s*(.-)%s*$")
			return code_part ~= ""
		end
	end
	return false
end

local function remove_inline_comment(line, patterns)
	if patterns.line then
		local comment_pos = line:find(patterns.line)
		if comment_pos then
			return line:sub(1, comment_pos - 1):gsub("%s+$", "") -- trim trailing spaces
		end
	end
	return line
end

function M.hide_comments(bufnr)
	local buf_state = get_buf_state(bufnr)
	local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
	local patterns = comment_patterns[filetype]

	if not patterns then return end


	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	-- Define the sign for gutter
	vim.fn.sign_define("CommentHidden", {
		text = M.placeholder or "💬",
		texthl = "Comment",
		numhl = "Comment"
	})

	-- Track which lines to remove and which to modify
	local lines_to_remove = {}
	local lines_to_modify = {} -- line_num -> new_content
	local remaining_line_count = 0

	for i, line in ipairs(lines) do
		if is_comment_only_line(line, patterns) then
			-- Store full-line comment
			table.insert(buf_state.comment_data, {
				content = line,
				type = "full_line",
				insert_after_line = remaining_line_count, -- Insert after this many remaining lines
				original_line = i
			})

			-- Mark this line for removal
			table.insert(lines_to_remove, i)

		elseif has_inline_comment(line, patterns) then
			local comment_start = get_inline_comment_pos(line, patterns)
			if comment_start then
				-- Store inline comment
				local code_part = remove_inline_comment(line, patterns)
				local comment_part = line:sub(comment_start)

				table.insert(buf_state.comment_data, {
					content = comment_part,
					type = "inline",
					line_index = remaining_line_count, -- Which line in the final buffer this belongs to
					original_line = i
				})

				-- Mark this line for modification
				lines_to_modify[i] = code_part
				remaining_line_count = remaining_line_count + 1
			else
				-- Fallback if comment detection failed
				remaining_line_count = remaining_line_count + 1
			end
		else
			-- Regular line, keep it
			remaining_line_count = remaining_line_count + 1
		end
	end

	-- Update buffer by removing comment lines (preserving undo)
	-- Remove lines in reverse order to maintain line numbers
	table.sort(lines_to_remove, function(a, b) return a > b end)
	for _, line_num in ipairs(lines_to_remove) do
		vim.api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, {})
	end

	-- Update lines that had inline comments removed
	for line_num, new_content in pairs(lines_to_modify) do
		vim.api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, { new_content })
	end

	-- Place signs for visual indication
	local current_line_count = vim.api.nvim_buf_line_count(bufnr)
	for _, comment in ipairs(buf_state.comment_data) do
		if comment.type == "full_line" then
			-- Place sign at the line after which the comment will be restored
			local sign_line = math.min(comment.insert_after_line + 1, current_line_count)
			if sign_line > 0 then
				local sign_id = vim.fn.sign_place(0, 0, "CommentHidden", bufnr, { lnum = sign_line })
				table.insert(buf_state.signs, sign_id)
			end
		elseif comment.type == "inline" then
			-- Place sign on the line with the removed inline comment
			local sign_line = comment.line_index + 1
			if sign_line <= current_line_count then
				local sign_id = vim.fn.sign_place(0, 0, "CommentHidden", bufnr, { lnum = sign_line })
				table.insert(buf_state.signs, sign_id)
			end
		end
	end

	buf_state.hidden = true
end

function M.show_comments(bufnr)
	local buf_state = get_buf_state(bufnr)

	if not buf_state.hidden then return end


	-- Get current buffer lines
	local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	-- Sort comments by their insertion points in reverse order
	-- (so we insert from bottom to top to avoid position shifts)
	table.sort(buf_state.comment_data, function(a, b)
		if a.type == "full_line" and b.type == "full_line" then
			return a.insert_after_line > b.insert_after_line
		elseif a.type == "inline" and b.type == "inline" then
			return a.line_index > b.line_index
		elseif a.type == "full_line" and b.type == "inline" then
			return a.insert_after_line >= b.line_index
		else -- a.type == "inline" and b.type == "full_line"
			return a.line_index > b.insert_after_line
		end
	end)

	-- Restore comments incrementally (preserving undo)
	for _, comment in ipairs(buf_state.comment_data) do
		if comment.type == "full_line" then
			-- Insert the comment after the specified line
			local insert_pos = comment.insert_after_line
			-- Ensure we don't go beyond current buffer size
			local line_count = vim.api.nvim_buf_line_count(bufnr)
			insert_pos = math.min(insert_pos, line_count)

			vim.api.nvim_buf_set_lines(bufnr, insert_pos, insert_pos, false, { comment.content })

		elseif comment.type == "inline" then
			-- Restore inline comment to the specified line
			local line_pos = comment.line_index
			local current_line_content = vim.api.nvim_buf_get_lines(bufnr, line_pos, line_pos + 1, false)
			if #current_line_content > 0 then
				local restored_line = current_line_content[1] .. comment.content
				vim.api.nvim_buf_set_lines(bufnr, line_pos, line_pos + 1, false, { restored_line })
			end
		end
	end

	-- Remove all gutter signs
	for _, sign_id in ipairs(buf_state.signs) do
		vim.fn.sign_unplace("", { buffer = bufnr, id = sign_id })
	end

	-- Reset state
	buf_state.comment_data = {}
	buf_state.signs = {}
	buf_state.hidden = false
end

function M.toggle_comments()
	local bufnr = vim.api.nvim_get_current_buf()
	local buf_state = get_buf_state(bufnr)

	if buf_state.hidden then
		M.show_comments(bufnr)
	else
		M.hide_comments(bufnr)
	end
end

function M.kill_comments(bufnr, opts)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	opts = opts or {}

	-- Default: kill both comment-only lines AND inline comments
	local kill_inline = not opts.preserve_inline -- default true
	local confirm = opts.confirm or false

	if confirm then
		local choice = vim.fn.confirm("Permanently delete all comments?", "&Yes\n&No", 2)
		if choice ~= 1 then return end
	end

	local filetype = vim.api.nvim_get_option_value('filetype', opts)
	local patterns = comment_patterns[filetype]

	if not patterns then
		vim.notify("No comment patterns for filetype: " .. filetype, vim.log.levels.WARN)
		return
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local filtered_lines = {}
	local removed_count = 0

	for _, line in ipairs(lines) do
		if is_comment_only_line(line, patterns) then
			-- Always remove comment-only lines
			removed_count = removed_count + 1
		elseif kill_inline and has_inline_comment(line, patterns) then
			-- Remove inline comment but keep the code part
			local code_part = remove_inline_comment(line, patterns)
			table.insert(filtered_lines, code_part)
			removed_count = removed_count + 1
		else
			-- Keep the line as-is
			table.insert(filtered_lines, line)
		end
	end

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, filtered_lines)
	vim.notify(string.format("Removed %d comment lines/sections", removed_count))
end

-- Auto-refresh when buffer changes (to handle new comments)
local function setup_autocmds()
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		callback = function()
			local bufnr = vim.api.nvim_get_current_buf()
			local buf_state = get_buf_state(bufnr)

			if buf_state.hidden then
				-- Refresh the hidden state to catch new/modified comments
				M.show_comments(bufnr)
				M.hide_comments(bufnr)
			end
		end,
	})

	-- Clean up when buffer is deleted
	vim.api.nvim_create_autocmd("BufDelete", {
		callback = function()
			local bufnr = tonumber(vim.fn.expand('<abuf>'))
			if state.buffers[bufnr] then
				M.show_comments(bufnr) -- Clean up extmarks
				state.buffers[bufnr] = nil
			end
		end,
	})
end

function M.setup(opts)
	opts = opts or {}

	-- Store the placeholder for use in sign definition
	M.placeholder = opts.placeholder or "💬"

	setup_autocmds()

	-- Default keymap
	if opts.keymap ~= false then
		local key = opts.keymap or '<leader>tc'
		vim.keymap.set('n', key, M.toggle_comments, { desc = 'Toggle comment visibility' })
	end

	-- Register KillComments command
	vim.api.nvim_create_user_command('KillComments', function(args)
		local opts = {}

		-- Parse arguments
		if args.args:match('--no%-inline') then
			opts.preserve_inline = true
		end
		if args.args:match('--confirm') then
			opts.confirm = true
		end

		M.kill_comments(nil, opts)
	end, {
		desc = 'Permanently remove all comments (use --no-inline to preserve inline comments)',
		nargs = '*',
		complete = function()
			return { '--no-inline', '--confirm' }
		end
	})
end

return M
