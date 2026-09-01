vim.pack.add({
	"https://github.com/mikavilpas/yazi.nvim",
})


vim.g.loaded_netrwPlugin = 1

-- vim.api.nvim_create_autocmd("UIEnter", {
-- 	callback = function()
-- 		require("yazi").setup({
-- 			open_for_directories = true,
-- 		})
-- 	end,
-- })
--
vim.keymap.set('n', '-', '<CMD>Yazi<CR>', {
	desc = 'Open parent directory',
})
