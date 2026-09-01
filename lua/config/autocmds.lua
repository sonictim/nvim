vim.pack.add({
	"https://github.com/sonictim/roto-rooter.nvim",
})

require('roto-rooter').setup({
	-- scope = "tab"
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.hl_op()
	end,
})



-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		if vim.fn.argc() == 0 then
-- 			require("telescope.builtin").find_files()
-- 		end
-- 	end,
-- })
