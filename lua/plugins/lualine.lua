vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

-- LUALINE
require("lualine").setup({
	-- theme = "tokyonight",
	sections = {
		lualine_c = {
			{
				function()
					local roto = require("roto-rooter")
					return roto.RRget_relative_dir()
					-- return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
				end,
				icon = "󰉋",
			},
			"filename",
		},
		-- lualine_x = {
		-- 	{
		-- 		function()
		-- 			return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		-- 		end,
		-- 		icon = "󰉋",
		-- 	},
		-- 	"encoding",
		-- 	"fileformat",
		-- 	"filetype",
		-- 	-- "filename",
		-- },
	},
})