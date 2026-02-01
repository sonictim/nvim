-- local pkg = require("mason-registry").get_package("json-lsp")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end
--
return { cmd = { "vscode-json-languageserver", "--stdio" }, filetypes = { "json" } }
