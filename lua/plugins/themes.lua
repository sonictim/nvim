vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/vague2k/vague.nvim",
	"https://github.com/catppuccin/nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/EdenEast/nightfox.nvim",
	"https://github.com/sainnhe/gruvbox-material",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/Mofiqul/dracula.nvim",
	"https://github.com/rose-pine/neovim",
	"https://github.com/Mofiqul/vscode.nvim",
	"https://github.com/projekt0n/github-nvim-theme",
	"https://github.com/sonictim/theme-template.nvim",
})

-- Setup all themes for easy switching

require("tokyonight").setup({
	styles = {
		comments = { italic = false }, -- Disable italics in comments
	},
})

require("catppuccin").setup({
	flavour = "mocha", -- or "macchiato", "frappe", "latte"
})

require("vague").setup({})
require("kanagawa").setup({})
require("nightfox").setup({})
require("gruvbox").setup({})
require("dracula").setup({})
require("rose-pine").setup({})

-- Setup theme-template (will uncomment after download completes)
-- require("theme-template").setup({})

-- Choose which theme to load (comment/uncomment to switch)
vim.cmd.colorscheme("tokyonight-night")
-- vim.cmd.colorscheme("vague")
-- vim.cmd.colorscheme("catppuccin-mocha")
-- vim.cmd.colorscheme("kanagawa")
-- vim.cmd.colorscheme("nightfox")
-- vim.cmd.colorscheme("carbonfox")
-- vim.cmd.colorscheme("gruvbox-material")
-- vim.cmd.colorscheme("gruvbox")
-- vim.cmd.colorscheme("dracula")
-- vim.cmd.colorscheme("rose-pine")
-- vim.cmd.colorscheme("vscode")
-- vim.cmd.colorscheme("github_dark")
-- vim.cmd.colorscheme("theme-template")

-- CSS COLORS
require("nvim-highlight-colors").setup({})
