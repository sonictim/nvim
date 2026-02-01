-- local pkg = require("mason-registry").get_package("buf-language-server")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end
--
return { cmd = { "buf", "beta", "lsp" }, filetypes = { "proto" } }
