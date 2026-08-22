vim.pack.add({ "https://github.com/sonictim/escape-hatch.nvim" })
require("escape-hatch").setup({
	-- timeout = 400,
	close_all_special_buffers = true,
	handle_completion_popups = false,
	completion_engine = "blink",
	-- debug = true,
	telescope_full_quit = true,

	preserve_buffers = {
		"tutor",
		"lualine",
	},
	-- normal_commands = {
	-- 	[1] = "smart_close", -- First escape: clear UI/exit modes
	-- },
	-- Custom commands (optional)
	commands = {
		save = "update",
		save_quit = "x",
		-- exit_terminal = 'hide',
	},
})
-- Add keybindings for toggle functions
-- vim.keymap.set("n", "<leader>tn", function()
-- 	require("escape-hatch").toggle_nuclear()
-- end, { desc = "[T]oggle escape-hatch [N]uclear option" })
-- vim.keymap.set("n", "<leader>tb", function()
-- 	require("escape-hatch").toggle_close_all_buffers()
-- end, { desc = "[T]oggle escape-hatch All [B]uffers" })
-- vim.keymap.set("n", "<leader>tp", function()
-- 	require("escape-hatch").toggle_close_all_buffers()
-- end, { desc = "[T]oggle escape-hatch Completion [P]opups" })
-- vim.keymap.set("n", "<leader>te", function()
-- 	require("escape-hatch").toggle_plugin()
-- end, { desc = "[T]oggle [E]scape-hatch" })
