vim.pack.add({
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
})
CustomOilBar = function()
  local path = vim.fn.expand '%'
  path = path:gsub('oil://', '')

  return '  ' .. vim.fn.fnamemodify(path, ':.')
end

require('oil').setup {
  columns = { 'icon' },
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['<C-k>'] = false,
    ['<C-j>'] = false,
    ['<M-h>'] = 'actions.select_split',
  },
  win_options = {
    winbar = '%{v:lua.CustomOilBar()}',
  },
  view_options = {
    show_hidden = true,
    skip_confirm_for_simple_edits = true,
    is_always_hidden = function(name, _)
      local folder_skip = { 'dev-tools.locks', 'dune.lock', '_build' }
      return vim.tbl_contains(folder_skip, name)
    end,
  },
}
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "oil",
--   callback = function()
--     vim.defer_fn(function()
--       -- Call the preview function directly
--       require("oil").open_preview()
--     end, 50)
--   end,
-- })
-- Open parent directory in current window
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Open parent directory in floating window
-- vim.keymap.set('n', '<space>-', require('oil').toggle_float, { desc = 'Toggle Oil Floating Window' })
