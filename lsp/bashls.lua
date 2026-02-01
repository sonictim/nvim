-- local pkg = require("mason-registry").get_package("bash-language-server")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end

return { cmd = { "bash-language-server", "start" }, filetypes = { "sh", "bash" } }
