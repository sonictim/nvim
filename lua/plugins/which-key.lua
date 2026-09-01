vim.pack.add({ "https://github.com/folke/which-key.nvim" })

require("which-key").setup({
	triggers = {
		{ "<auto>", mode = "nixsotc" },
		{ "s",      mode = { "n", "v" } },
	},
	disable = {
		ft = { "yazi" },
		bt = { "terminal" },
	},
	timeout_ms = 500,
	-- delay between pressing a key and opening which-key (milliseconds)
	-- this setting is independent of vim.o.timeoutlen
	delay = 0,
	sort = { "group", "alphanum" },
	icons = {
		-- set icon mappings to true if you have a Nerd Font
		mappings = vim.g.have_nerd_font,
		-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
		-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
		keys = vim.g.have_nerd_font and {} or {
			Up = "<Up> ",
			Down = "<Down> ",
			Left = "<Left> ",
			Right = "<Right> ",
			C = "<C-…> ",
			M = "<M-…> ",
			D = "<D-…> ",
			S = "<S-…> ",
			CR = "<CR> ",
			Esc = "<Esc> ",
			ScrollWheelDown = "<ScrollWheelDown> ",
			ScrollWheelUp = "<ScrollWheelUp> ",
			NL = "<NL> ",
			BS = "<BS> ",
			Space = "<Space> ",
			Tab = "<Tab> ",
			F1 = "<F1>",
			F2 = "<F2>",
			F3 = "<F3>",
			F4 = "<F4>",
			F5 = "<F5>",
			F6 = "<F6>",
			F7 = "<F7>",
			F8 = "<F8>",
			F9 = "<F9>",
			F10 = "<F10>",
			F11 = "<F11>",
			F12 = "<F12>",
		},
	},

	-- Document existing key chains
	spec = {
		{ "<leader>s", group = "[S] Search" },
		{ "<leader>t", group = "[T] Toggle" },
		{ "<leader>q", group = "[Q] QuickFix" },
		{ "<leader>a", group = "[A] Select All" },
		{ "<leader>b", group = "[B] Buffer" },
		{ "<leader>g", group = "[G] Git" },
		{ "<leader>l", group = "[L] LSP" },
		{ "<leader>h", group = "[H] Git Hunk",  mode = { "n", "v" } },
		{ "<leader>u", group = "[U] Update",    mode = { "n", "v" } },
	},
})
