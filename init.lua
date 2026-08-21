vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal.
-- Must be set before any plugin setup() reads it (which-key does).
vim.g.have_nerd_font = true

require("vim._core.ui2").enable({})
require("config.autocmds")
require("config.keymaps")
require("config.lsp")

-- Manually require all plugin config files
require("plugins.lualine")
-- require("plugins.statusline")
require("plugins.themes")
require("plugins.escape-hatch")
require("plugins.fugitive")
require("plugins.gitsigns")
require("plugins.indent_line")
require("plugins.mini")

require("plugins.oil")
require("plugins.quick-install")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.which-key")
-- Run this last to override options set by plugins
require("config.options")
require("config.neovide")

-- In your config
-- require('plugins.enough-already').setup({
-- 	placeholder = "⋯", -- or "💬", "// ...", etc.
-- 	keymap = '<leader>tc'
-- })
-- require("config.nix")

-- -- ROTO ROOTER ALTERNATIVE
-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufEnter" }, {
-- 	group = vim.api.nvim_create_augroup("my.rooter", {}),
-- 	callback = function(ev)
-- 		if vim.bo[ev.buf].buftype ~= "" then return end
-- 		local root = vim.fs.root(ev.buf, { ".git", "Cargo.toml", "package.json" })
-- 		if not root or root == vim.fn.getcwd(0) then return end
-- 		vim.cmd.bcd(root) -- pins it; 0.13+
-- 		vim.cmd.lcd(root) -- propagates to pickers/floats
-- 	end,
-- })
