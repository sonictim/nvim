-- local pkg = require("mason-registry").get_package("svelte-language-server")
-- if not pkg:is_installed() then
-- 	pkg:install()
-- end
--
return { cmd = { "svelteserver", "--stdio" }, filetypes = { "svelte" } }
