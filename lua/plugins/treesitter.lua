-- WARNING!  YOU MAY NEED TO MANUALLY SWITCH TO THE MASTER BRANCHES
-- WARNING!  YOU MAY NEED TO MANUALLY SWITCH TO THE MASTER BRANCHES
-- WARNING!  YOU MAY NEED TO MANUALLY SWITCH TO THE MASTER BRANCHES
-- WARNING!  YOU MAY NEED TO MANUALLY SWITCH TO THE MASTER BRANCHES


vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

-- Parser installation
require('nvim-treesitter').install {
    'rust', 'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc',
    'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
    'javascript', 'typescript', 'python', 'zig', 'nix', 'svelte',
    'json', 'toml', 'css',
}

-- Textobject selection keymaps
local select = require("nvim-treesitter-textobjects.select")
local sel_keymaps = {
    { "af", "@function.outer",    "Around function" },
    { "if", "@function.inner",    "Inside function" },
    { "ac", "@class.outer",       "Around class" },
    { "ic", "@class.inner",       "Inside class" },
    { "aa", "@parameter.outer",   "Around argument" },
    { "ia", "@parameter.inner",   "Inside argument" },
    { "ai", "@conditional.outer", "Around conditional" },
    { "ii", "@conditional.inner", "Inside conditional" },
    { "al", "@loop.outer",        "Around loop" },
    { "il", "@loop.inner",        "Inside loop" },
    { "ab", "@block.outer",       "Around block" },
    { "ib", "@block.inner",       "Inside block" },
    { "a/", "@comment.outer",     "Around comment" },
    { "i/", "@comment.inner",     "Inside comment" },
}

for _, map in ipairs(sel_keymaps) do
    vim.keymap.set({ "x", "o" }, map[1], function()
        select.select_textobject(map[2], "textobjects")
    end, { desc = map[3] })
end

-- Movement keymaps
local move = require("nvim-treesitter-textobjects.move")

local move_keymaps = {
    { "]f", "@function.outer",  "next_start",     "Next function start" },
    { "]F", "@function.outer",  "next_end",       "Next function end" },
    { "[f", "@function.outer",  "previous_start", "Prev function start" },
    { "[F", "@function.outer",  "previous_end",   "Prev function end" },
    { "]c", "@class.outer",     "next_start",     "Next class start" },
    { "]C", "@class.outer",     "next_end",       "Next class end" },
    { "[c", "@class.outer",     "previous_start", "Prev class start" },
    { "[C", "@class.outer",     "previous_end",   "Prev class end" },
    { "]a", "@parameter.inner", "next_start",     "Next argument" },
    { "]A", "@parameter.inner", "next_end",       "Next argument end" },
    { "[a", "@parameter.inner", "previous_start", "Prev argument" },
    { "[A", "@parameter.inner", "previous_end",   "Prev argument end" },
    { "]/", "@comment.outer",   "next_start",     "Next comment" },
    { "[/", "@comment.outer",   "previous_start", "Prev comment" },
}

for _, map in ipairs(move_keymaps) do
    local fn
    if map[3] == "next_start" then
        fn = move.goto_next_start
    elseif map[3] == "next_end" then
        fn = move.goto_next_end
    elseif map[3] == "previous_start" then
        fn = move.goto_previous_start
    elseif map[3] == "previous_end" then
        fn = move.goto_previous_end
    end
    vim.keymap.set("n", map[1], function()
        fn(map[2], "textobjects")
    end, { desc = map[4] })
end

-- Treesitter-context
require('treesitter-context').setup({
    enable = true,
    multiwindow = false,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = 'inner',
    mode = 'cursor',
    separator = nil,
    zindex = 20,
    on_attach = nil,
})

-- vim.keymap.set('n', '<leader>c', function()
--     require('treesitter-context').go_to_context(vim.v.count1)
-- end, { silent = true, desc = '[C] Jump to Context' })
--
-- List all comments in quickfix
-- vim.keymap.set('n', '<leader>cl', function()
--     local pattern = vim.bo.filetype == 'lua' and '%-%-' or
--         vim.bo.filetype == 'rust' and '//' or
--         vim.bo.filetype == 'python' and '#' or '//'
--
--     local bufnr = vim.api.nvim_get_current_buf()
--     local filename = vim.api.nvim_buf_get_name(bufnr)
--     local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
--     local qf_list = {}
--
--     for i, line in ipairs(lines) do
--         if line:match(pattern) then
--             table.insert(qf_list, {
--                 bufnr = bufnr,
--                 filename = filename,
--                 lnum = i,
--                 col = 1,
--                 text = line:gsub("^%s*", ""),
--             })
--         end
--     end
--
--     if #qf_list > 0 then
--         vim.fn.setqflist(qf_list)
--         vim.cmd('copen')
--         print(string.format("Found %d comments", #qf_list))
--     else
--         print("No comments found")
--     end
-- end, { desc = 'List all comments' })
--
local function qf_from_nodes(node_type, label)
    local bufnr = vim.api.nvim_get_current_buf()
    local parser = vim.treesitter.get_parser(bufnr)

    if not parser then
        vim.notify("No Treesitter parser available", vim.log.levels.WARN)
        return
    end

    local tree = parser:parse()[1]
    local root = tree:root()
    local results = {}

    local function visit(node)
        if node:type() == node_type then
            local row, col = node:start()
            local text = vim.treesitter.get_node_text(node, bufnr)

            table.insert(results, {
                bufnr = bufnr,
                filename = vim.api.nvim_buf_get_name(bufnr),
                lnum = row + 1,
                col = col + 1,
                text = vim.trim(text):gsub("\n.*", "…"),
            })

            return
        end

        for child in node:iter_children() do
            visit(child)
        end
    end

    visit(root)

    if #results == 0 then
        vim.notify("No " .. label .. " found")
        return
    end

    vim.fn.setqflist({}, " ", {
        title = label,
        items = results,
    })
    vim.cmd("copen")

    vim.notify(string.format("Found %d %s", #results, label))
end


-- Jump to Treesitter context
vim.keymap.set("n", "<leader>c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "[C] Jump to Context" })


-- Comments
vim.keymap.set("n", "<leader>cc", function()
    qf_from_nodes("comment", "comments")
end, { desc = "[C]omments" })


-- vim.keymap.set("n", "<leader>cc", function()
--     require("telescope.builtin").lsp_document_symbols({
--         symbols = { "comment", "comments" },
--     })
-- end, { desc = "[C]omments" })

-- String literals
vim.keymap.set("n", "<leader>cs", function()
    qf_from_nodes("string", "string literals")
end, { desc = "[S]tring literals" })

-- vim.keymap.set("n", "<leader>cs", function()
--     require("telescope.builtin").lsp_document_symbols({
--         symbols = { "string", "string literals" },
--     })
-- end, { desc = "[S]tring Literals" })
--
vim.keymap.set("n", "<leader>cd", function()
    vim.diagnostic.setqflist({
        open = true,
    })
end, { desc = "[D]iagnostics" })


vim.keymap.set("n", "<leader>cf", function()
    require("telescope.builtin").lsp_document_symbols({
        symbols = { "function", "method" },
    })
end, { desc = "[F]unctions" })

-- vim.keymap.set("n", "<leader>ct", function()
--     qf_from_nodes("enum", "struct", "union", "enum")
-- end, { desc = "[S]tring literals" })
--
-- vim.keymap.set("n", "<leader>ct", function()
--     require("telescope.builtin").lsp_document_symbols({
--         symbols = { "class", "struct", "enum", "union", },
--     })
-- end, { desc = "[T]ypes" })
