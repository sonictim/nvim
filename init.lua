vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true


require("vim._core.ui2").enable({})
require("config.autocmds")
require("config.keymaps")
require("config.lsp")
-- require("plugins.lualine")
require("plugins.statusline")
require("plugins.themes")
-- require("plugins.escape-hatch")
require("plugins.fugitive")
require("plugins.gitsigns")
require("plugins.indent_line")
require("plugins.mini")
require("plugins.oil")
require("plugins.quick-install")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.which-key")
require("config.options")
