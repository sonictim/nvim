return {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	on_attach = function(client, bufnr)
		-- your custom on_attach logic
	end,
	-- capabilities = capabilities, -- from cmp_nvim_lsp or similar
}
