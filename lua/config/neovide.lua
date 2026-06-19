-- Neovide-only settings
if vim.g.neovide then
	vim.o.guifont = "\"JetBrainsMono Nerd Font:h16\""

	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_floating_blur_amount_x = 0
	vim.g.neovide_floating_blur_amount_y = 0

	vim.cmd("highlight clear Normal")
	vim.cmd("highlight clear NormalNC")
	vim.cmd("highlight clear SignColumn")
	vim.cmd("highlight clear LineNr")
	vim.cmd("highlight clear VertSplit")
	vim.cmd("colorscheme " .. vim.g.colors_name)
	-- vim.opt.mouse = ""
	-- vim.opt.mousescroll = "ver:0,hor:0"
end
