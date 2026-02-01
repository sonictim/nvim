-- local pkg = require("mason-registry").get_package("html-lsp")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end
--
return { cmd = { "vscode-html-languageserver", "--stdio" }, filetypes = { "html" } }
