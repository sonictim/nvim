vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
require("fidget").setup({})

local lsps = {
    "rust_analyzer",
    "lua_ls",
    "bashls",
    "jsonls",
    "taplo",
    "ts_ls",
    "svelte",
    "html",
    "cssls",
    "nil_ls",
    "buf_ls",
    "sourcekit",
    "clangd",
    "zls",
}
--DONT FORGET TO ADD THE CORRESPONDING .LUA FILES to the LSP directory
vim.lsp.enable(lsps)

-- LSP Configuration - minimal custom mappings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Navigation with Telescope(better than built-in)
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- Essential actions
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Inlay hints toggle
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            map("<leader>th", function()
                    vim.lsp.inlay_hint.enable(
                        not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                end,
                "[T]oggle Inlay [H]ints")
        end
        -- Auto Completion
        if client:supports_method("textDocument/completion") then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
            vim.keymap.set("i", "<C-Space>", function()
                vim.lsp.completion.get()
            end
            )
        end
    end,
})

--Diagnostics
vim.diagnostic.config({
    --Default
    -- virtual_lines = true,
    --Or Custom Options instead
    virtual_lines = { current_line = true },
})

-- Function: format buffer with LSP, fallback to ggVG=
local function format_or_fallback()
    local success = pcall(function()
        vim.lsp.buf.format({ async = false })
    end)

    if not success then
        vim.cmd("normal! ggVG=")
    end
end

-- Keymap for manual formatting
vim.keymap.set("n", "<leader>f", format_or_fallback, { desc = "[F]ormat buffer (LSP or fallback)" })

-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = format_or_fallback,
})

vim.keymap.set("n", "<leader>lr", function()
    for _, client in pairs(vim.lsp.get_clients()) do
        client:stop()
    end
    vim.lsp.enable(lsps)
end, { desc = "[LSP] Restart all servers" })


vim.keymap.set("n", "<leader>ls", function()
    local clients = vim.lsp.get_clients()

    if #clients > 0 then
        for _, client in pairs(clients) do
            client:stop()
        end
    else
        vim.lsp.enable(lsps)
    end
end, { desc = "[LSP] Toggle start/stop" })
