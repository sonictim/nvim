require("vim._core.ui2").enable({})


require("config.lsp")
require("config.autocmds")
require("config.keymaps")


-- Manually require all plugin config files
require("plugins.lualine")
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
require('plugins.enough-already').setup({
	placeholder = "⋯", -- or "💬", "// ...", etc.
	keymap = '<leader>tc'
})
-- require("config.nix")
