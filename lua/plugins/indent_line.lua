vim.pack.add({"https://github.com/lukas-reineke/indent-blankline.nvim"})

-- Add indentation guides even on blank lines
-- Enable `lukas-reineke/indent-blankline.nvim`
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
