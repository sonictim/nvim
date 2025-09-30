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
