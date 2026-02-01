-- local pkg = require("mason-registry").get_package("typescript-language-server")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end
--
return { cmd = { "typescript-language-server", "--stdio" }, filetypes = { "typescript", "javascript" } }
