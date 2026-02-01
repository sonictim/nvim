-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_user_command("W", "w !sudo tee %", {})

-- Define a proper Lua function to write and source the current file
local function write_and_source()
	vim.cmd("write")
	vim.cmd("source %")
end

-- Create a command (must be uppercase)
vim.api.nvim_create_user_command("Wso", write_and_source, {})

-- Optional: lowercase alias using cabbrev
vim.cmd("cabbrev wso Wso")

vim.api.nvim_create_user_command('PackUpdate', function()
	local pack_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/*'
	local plugins = vim.fn.glob(pack_path, false, true)

	for _, plugin in ipairs(plugins) do
		if vim.fn.isdirectory(plugin .. '/.git') == 1 then
			local name = vim.fn.fnamemodify(plugin, ':t')

			-- Fetch updates from remote
			vim.fn.system('git -C ' .. plugin .. ' fetch')

			-- Check if behind remote
			local behind = vim.fn.system('git -C ' .. plugin .. ' rev-list HEAD..@{u} --count')
			behind = tonumber(behind) or 0

			if behind > 0 then
				print('Updating ' .. name .. ' (' .. behind .. ' commits behind)')
				vim.fn.system('git -C ' .. plugin .. ' pull')
			else
				print(name .. ' is up-to-date')
			end
		end
	end
	print('Updates complete!')
end, {})


-- Copy C++ function declarations to system clipboard
vim.api.nvim_create_user_command("Cpp2h", function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local decls = {}

	-- Simple regex to match common function definitions
	local pattern = "^%s*[%w_:<>~]+[%s*&]+[%w_:~]+%s*%b()"

	for _, line in ipairs(lines) do
		if line:match(pattern) and line:match("{%s*$") then
			-- Remove trailing { and whitespace
			local decl = line:gsub("{%s*$", ";")
			table.insert(decls, decl)
		end
	end

	if #decls == 0 then
		print("No functions found!")
		return
	end

	-- Join and copy to system clipboard
	local text = table.concat(decls, "\n")
	vim.fn.setreg("+", text)
	print("Function declarations copied to clipboard!")
end, {})
