vim.pack.add({
	"https://github.com/NMAC427/guess-indent.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/sonictim/roto-rooter.nvim",
	"https://github.com/DreamMaoMao/yazi.nvim",
})

-- Detect tabstop and shiftwidth automatically
require('guess-indent').setup({})

-- Adds git related signs to the gutter, as well as utilities for managing changes
require('gitsigns').setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- TODO Comments
require('todo-comments').setup({ signs = false })

-- Roto Rooter
require('roto-rooter').setup({})
