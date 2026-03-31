require("config.lsp")
require("config.autocmds")
require("config.keymaps")
require("config.health")
require("config.neovide")


-- Manually require all plugin config files
-- require("plugins.autocomplete")
-- require("plugins.autoformat")
require("plugins.autopairs")
require("plugins.lualine")
require("plugins.themes")
-- require("plugins.debug")
require("plugins.escape-hatch")
require("plugins.fugitive")
require("plugins.gitsigns")
require("plugins.indent_line")
-- require("plugins.lint")
require("plugins.mini")
require("plugins.oil")
require("plugins.quick-install")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.which-key")
-- require("plugins.ChatGPT")
-- Run this last to override options set by plugins
require("config.options")


-- In your config
require('plugins.enough-already').setup({
	placeholder = "⋯", -- or "💬", "// ...", etc.
	keymap = '<leader>tc'
})
-- require("config.nix")
