-- local pkg = require("mason-registry").get_package("css-lsp")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end

return { cmd = { "vscode-css-languageserver", "--stdio" }, filetypes = { "css", "scss", "less" } }
