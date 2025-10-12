return {
	cmd = { "nil" },
	filetypes = { "nix" },
	root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'flake.nix', 'default.nix' }, { upward = true })[1]),
	settings = {
		['nil'] = {
			formatting = {
				command = { "nixpkgs-fmt" },
			},
		},
	},
}
