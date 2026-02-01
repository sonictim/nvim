-- local pkg = require("mason-registry").get_package("taplo")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end
--
return { cmd = { "taplo", "lsp", "stdio" }, filetypes = { "toml" } }
