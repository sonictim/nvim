vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Save current file with Super+S
vim.keymap.set({ "n", "i", "v" }, "<D-s>", function()
	vim.cmd("write")
end, { desc = "Save file" })
vim.keymap.set({ "n", "i", "v" }, "<D-S>", function()
	vim.cmd("wall")
end, { desc = "Save all files" })

vim.keymap.set("n", "<F1>", "<cmd>vert help<CR>")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>ql", vim.diagnostic.setloclist, { desc = "Open local diagnostic quickfix list" })
vim.keymap.set("n", "<leader>qg", vim.diagnostic.setqflist, { desc = "Open global diagnostic quickfix List" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode

-- FROM PRIMEAGEN
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without Yanking" })
vim.keymap.set({ "x", "v" }, "<leader>d", '"_d', { desc = "delete without Yanking" })

-- vim.keymap.set("n", "n", "nzzzv", { desc = "Find Next, Center View, unfold if hidden" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Find Prev, Center View, unfold if hidden" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move Down and Recenter" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move Up and Recenter" })
-- Disable F1 in normal, insert, and visual modes
vim.keymap.set({ "n", "i", "v" }, "<F1>", "<Nop>", { desc = "Disable accidental help" })

-- Move Lines in Visual Mode
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
-- vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Replace Word Under Cursor
vim.keymap.set(
	"n",
	"<leader>r",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[R]eplace word under cursor" }
)

--Qick buffer switching
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>")
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>")
vim.keymap.set("n", "<leader>bx", ":!chmod +x %<CR>", { desc = "[B]uffer make e[X]ecutable" })
vim.keymap.set("n", "<leader>bX", ":!%<CR>", { desc = "[B]uffer e[X]ecute" })
vim.keymap.set("n", "<leader>bc", ":!sudo rm config.h<CR>:!sudo make clean install<CR>",
	{ desc = "[B]uffer compile [C]" })
vim.keymap.set("n", "<leader>br", ":!cargo run", { desc = "[B]uffer compile [R]ust" })

--Quick All Yank or Replace
vim.keymap.set("n", "<leader>ay", "ggVGy", { desc = "Yank entire buffer" })
vim.keymap.set("n", "<leader>ap", "ggVGp", { desc = "Paste over entire buffer" })
vim.keymap.set("n", "<leader>aa", "ggVG", { desc = "Select entire buffer" })
vim.keymap.set("n", "<leader>a=", "ggVG=", { desc = "Format entire buffer" })

vim.keymap.set("n", "<leader>\\", vim.cmd.vsplit, { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>-", vim.cmd.split, { desc = "Horizontal Split" })
--swap Commands and go to next with F/T
-- vim.keymap.set({ 'n', 'v' }, ';', ':')
-- vim.keymap.set({ 'n', 'v' }, ':', ';')
--
--
--
-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("i", "<C-h>", "<left>", { desc = "Move cursor left" })
vim.keymap.set("i", "<C-l>", "<right>", { desc = "Move cursor right" })
vim.keymap.set("i", "<C-j>", "<down>", { desc = "Move cursor down" })
vim.keymap.set("i", "<C-k>", "<up>", { desc = "Move cursor up" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

local transparent = true

function toggle_transparency()
	transparent = not transparent
	if transparent then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
		vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
	else
		-- reset to colorscheme defaults
		vim.cmd("highlight clear Normal")
		vim.cmd("highlight clear NormalNC")
		vim.cmd("highlight clear SignColumn")
		vim.cmd("highlight clear LineNr")
		vim.cmd("highlight clear VertSplit")
		vim.cmd("colorscheme " .. vim.g.colors_name)
	end
end

-- Example keybinding: <leader>tt
vim.keymap.set("n", "<leader>ty", toggle_transparency, { desc = "Toggle Transparenc[Y]" })
-- require("plugins.quickfix").setup()
-- require 'custom.method_browser'
-- Toggle between cargo check and clippy

local function toggle_rust_check()
	local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
	if #clients == 0 then
		print("No rust-analyzer client found")
		return
	end

	local client = clients[1]
	local current_cmd = client.config.settings["rust-analyzer"]["checkOnSave"]["command"]

	if current_cmd == "clippy" then
		-- Switch to check
		client.config.settings["rust-analyzer"]["checkOnSave"]["command"] = "check"
		print("Switched to cargo check")
	else
		-- Switch to clippy
		client.config.settings["rust-analyzer"]["checkOnSave"]["command"] = "clippy"
		print("Switched to cargo clippy")
	end

	-- Notify the LSP of the change and trigger refresh
	client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
end

-- Set up the keybinding
vim.keymap.set("n", "<leader>tc", toggle_rust_check, { desc = "[T]oggle Rust [C]heck/Clippy" })

local qbuf = -1
local job_id = 0

local function quickterm()
	local wins = vim.fn.win_findbuf(qbuf)
	if #wins > 0 then
		for _, w in ipairs(wins) do
			vim.api.nvim_win_close(w, true)
		end
	else
		vim.cmd.split()
		vim.cmd.wincmd("J")
		vim.api.nvim_win_set_height(0, 10)
		if qbuf > 0 then
			vim.api.nvim_win_set_buf(0, qbuf)
		else
			vim.cmd.term()
			qbuf = vim.api.nvim_get_current_buf()
			job_id = vim.b.terminal_job_id
		end
		vim.cmd.startinsert()
	end
end

vim.keymap.set({ "n", "t" }, "<leader>tt", quickterm, { desc = "[T]oggle Quick [T]erminal" })

-- vim.keymap.set('n', '<leader>gc', function()
--   vim.fn.chansend(job_id, { "git add . && git commit -m '" })
-- end)
--
vim.keymap.set("n", "<leader>tv", function()
	vim.cmd.vsplit()
	vim.api.nvim_win_set_width(0, 80)
	vim.cmd.term()
	vim.cmd.startinsert()
end)
--
-- vim.api.nvim_create_autocmd('BufDelete', {
--   callback = function()
--     local bufs = vim.fn.getbufinfo { buflisted = 1 }
--     if #bufs == 0 then
--       -- No listed buffers left, open your file explorer
--       -- Example for Oil:
--       require('oil').open()
--       -- Or for netrw: vim.cmd("Explore")
--     end
--   end,
-- })
-- Create a command to save as sudo
--
-- Function to toggle the closest boolean on current line
local function toggle_boolean()
	local line = vim.api.nvim_get_current_line()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local col = cursor_pos[2] + 1 -- Convert to 1-indexed

	-- Define boolean patterns (case-sensitive)
	local patterns = {
		{ pattern = "true",  replacement = "false" },
		{ pattern = "false", replacement = "true" },
		{ pattern = "True",  replacement = "False" },
		{ pattern = "False", replacement = "True" },
		{ pattern = "TRUE",  replacement = "FALSE" },
		{ pattern = "FALSE", replacement = "TRUE" },
	}

	local closest_match = nil
	local closest_distance = math.huge

	-- Find all boolean matches on the line
	for _, bool_pair in ipairs(patterns) do
		local start_pos = 1
		while true do
			local match_start, match_end = string.find(line, "%f[%w]" .. bool_pair.pattern .. "%f[^%w]", start_pos)
			if not match_start then
				break
			end

			-- Calculate distance from cursor to this match
			local match_center = math.floor((match_start + match_end) / 2)
			local distance = math.abs(col - match_center)

			-- Update closest match if this one is closer
			if distance < closest_distance then
				closest_distance = distance
				closest_match = {
					start_pos = match_start,
					end_pos = match_end,
					original = bool_pair.pattern,
					replacement = bool_pair.replacement,
				}
			end

			start_pos = match_end + 1
		end
	end

	-- Toggle the closest boolean if found
	if closest_match then
		local new_line = string.sub(line, 1, closest_match.start_pos - 1)
			.. closest_match.replacement
			.. string.sub(line, closest_match.end_pos + 1)

		vim.api.nvim_set_current_line(new_line)

		-- Adjust cursor position if the replacement is different length
		local length_diff = string.len(closest_match.replacement) - string.len(closest_match.original)
		if col > closest_match.end_pos then
			vim.api.nvim_win_set_cursor(0, { cursor_pos[1], cursor_pos[2] + length_diff })
		end

		print("Toggled: " .. closest_match.original .. " → " .. closest_match.replacement)
	else
		print("No boolean found on current line")
	end
end

-- Set up the keybinding
vim.keymap.set("n", "<leader>tb", toggle_boolean, {
	desc = "[T]oggle closest [B]oolean on current line",
	noremap = true,
	silent = true,
})

vim.keymap.set("n", "<leader>u", function()
	-- Only update if file has a name
	if vim.fn.expand("%") ~= "" then
		vim.cmd("update")
	end
	vim.cmd("source")
	vim.pack.update()
end, { desc = "[U]pdate" })
