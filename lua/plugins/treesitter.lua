vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

-- Build treesitter parsers (defer until treesitter is loaded)
vim.defer_fn(function()
	if vim.fn.exists(':TSUpdate') == 2 then
		vim.cmd("TSUpdate")
	end
end, 1500)

-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup({
      ensure_installed = { 'rust', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- Functions
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',

            -- Classes
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',

            -- Parameters/arguments
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',

            -- Conditionals
            ['ai'] = '@conditional.outer',
            ['ii'] = '@conditional.inner',

            -- Loops
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',

            -- Blocks
            ['ab'] = '@block.outer',
            ['ib'] = '@block.inner',

            -- Comments
            ['a/'] = '@comment.outer',
            ['i/'] = '@comment.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
            [']a'] = '@parameter.inner',
            [']/'] = '@comment.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
            [']A'] = '@parameter.inner',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
            ['[a'] = '@parameter.inner',
            ['[/'] = '@comment.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
            ['[A'] = '@parameter.inner',
          },
        },
      },
})

-- There are additional nvim-treesitter modules that you can use to interact
-- with nvim-treesitter. You should go explore a few and see what interests you:
--
--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

-- Configure treesitter-context
require('treesitter-context').setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- minimum editor window height to enable context. values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})

vim.keymap.set('n', '<leader>c', function()
	require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true, desc = 'Jump to Context' })

-- List all comments in quickfix
vim.keymap.set('n', '<leader>cl', function()
	local pattern = vim.bo.filetype == 'lua' and '%-%-' or
	               vim.bo.filetype == 'rust' and '//' or
	               vim.bo.filetype == 'python' and '#' or '//'

	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local qf_list = {}

	for i, line in ipairs(lines) do
		if line:match(pattern) then
			table.insert(qf_list, {
				bufnr = bufnr,
				filename = filename,
				lnum = i,
				col = 1,
				text = line:gsub("^%s*", ""),
			})
		end
	end

	if #qf_list > 0 then
		vim.fn.setqflist(qf_list)
		vim.cmd('copen')
		print(string.format("Found %d comments", #qf_list))
	else
		print("No comments found")
	end
end, { desc = 'List all comments' })
