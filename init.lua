vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true


require("vim._core.ui2").enable({})
require("config.lsp")

-- require("plugins.lualine")
require("config.statusline")
require("plugins.themes")
require("plugins.ui-improvements")

require("plugins.git")

require("plugins.telescope")
require("plugins.treesitter")
require("plugins.yazi")

require("plugins.which-key")
require("plugins.mini")
require("plugins.escape-hatch")
require("config.autocmds")
require("config.keymaps")

require("config.options")
