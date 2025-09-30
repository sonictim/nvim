return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust", "rs" },
	settings = {
		["rust-analyzer"] = {
			checkOnSave = true,
			check = {
				command = "clippy",
			},
		},
	},
}
