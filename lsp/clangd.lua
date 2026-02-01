-- local pkg = require("mason-registry").get_package("clangd")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end
--
return {
	cmd = { "clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=never",
		"--completion-style=detailed",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	on_attach = function(client, bufnr)
		-- your custom on_attach logic
	end,
	-- capabilities = capabilities, -- from cmp_nvim_lsp or similar
}
