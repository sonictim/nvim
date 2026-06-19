return {
	cmd = { "marksman", "server" },
	filetypes = { "markdown" },
	-- Prefer a project root (marksman config or git), but fall back to the
	-- file's own directory so marksman still attaches to standalone notes.
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root = vim.fs.root(bufnr, { ".marksman.toml", ".git" })
		on_dir(root or vim.fs.dirname(fname))
	end,
}
