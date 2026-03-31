vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup({
	mappings = {
		add = 'sa',
		delete = 'sd',
		find = 'sf',
		find_left = 'sF',
		highlight = 'sh',
		replace = 'sr',
		update_n_lines = 'sn',
	},
})
