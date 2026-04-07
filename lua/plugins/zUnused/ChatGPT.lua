vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/jackMort/ChatGPT.nvim.git",
	"https://github.com/MunifTanjim/nui.nvim.git",
	-- "https://github.com/nvim-lua/plenary.nvim.git",
	"https://github.com/nvim-telescope/telescope.nvim.git",
})


require("chatgpt").setup({
	api_key_cmd = "echo $OPENAI_API_KEY", -- Make sure your key is exported in your shell
	chat_layout = "vertical",      -- optional: vertical or horizontal
})
