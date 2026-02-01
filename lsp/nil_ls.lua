-- local pkg = require("mason-registry").get_package("nil")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end
--
return {
	cmd = { "nil" },
	filetypes = { "nix" },
	root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'flake.nix', 'default.nix' }, { upward = true })[1]),
	settings = {
		['nil'] = {
			formatting = {
				command = { "nixpkgs-fmt" },
			},
			nix = {
				flake = {
					autoArchive = true,
				},
			},
		},
	},
}
