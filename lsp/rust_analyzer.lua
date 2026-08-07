local on_attach = function(client, bufnr)
	vim.bo[bufnr].makeprg = "cargo build"
	vim.b[bufnr].runprg = "cargo run"
end
--
-- local pkg = require("mason-registry").get_package("rust-analyzer")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end
--
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
