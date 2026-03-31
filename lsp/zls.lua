vim.filetype.add({
	extension = {
		zon = "zig"
	}
}) -- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0
-- disable format-on-save from `ziglang/zig.vim`
vim.g.zig_fmt_autosave = 0
-- Formatting with ZLS matches `zig fmt`.
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = { "*.zig", "*.zon" },
	callback = function(ev)
		vim.lsp.buf.format()
	end
})
return {
	cmd = { "zls" },
	filetypes = { "zig" },
	root_markers = { "build.zig" },
	-- There are two ways to set config options:
	--   - edit your `zls.json` that applies to any editor that uses ZLS
	--   - set in-editor config options with the `settings` field below.
	--
	-- Further information on how to configure ZLS:
	-- https://zigtools.org/zls/configure/
	settings = {
		zls = {
			-- Whether to enable build-on-save diagnostics
			--
			-- Further information about build-on save:
			-- https://zigtools.org/zls/guides/build-on-save/
			enable_build_on_save = true,

			-- omit the following line if `zig` is in your PATH
			-- zig_exe_path = '/path/to/zig_executable'
		}
	},
}
