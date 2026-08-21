vim.pack.add({
	"https://github.com/NMAC427/guess-indent.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/sonictim/roto-rooter.nvim",
	"https://github.com/DreamMaoMao/yazi.nvim",
	"https://github.com/windwp/nvim-autopairs",
})

require('guess-indent').setup({})

require('todo-comments').setup({ signs = false })

require('roto-rooter').setup({})

require('nvim-autopairs').setup({})
