return {
	cmd = { "xcrun", "sourcekit-lsp" },
	filetypes = { "swift" },
	root_dir = vim.fs.root(0, { "Package.swift", ".git" }),
}
