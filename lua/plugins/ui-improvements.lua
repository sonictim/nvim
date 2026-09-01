vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/NMAC427/guess-indent.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
})

require('guess-indent').setup({})
require('todo-comments').setup({ signs = false })
require("nvim-highlight-colors").setup({})
require('nvim-autopairs').setup({})
-- require('roto-rooter').setup({})

-- Add indentation guides even on blank lines
-- See `:help ibl`
require("ibl").setup({
	enabled = true,
	debounce = 200,
	indent = {
		char = "│", -- Character for indent lines
		tab_char = "│",
	},
	whitespace = {
		highlight = { "Whitespace", "NonText" },
	},
	scope = {
		enabled = true, -- Highlight current scope
		show_start = true,
		show_end = true,
	},
})
