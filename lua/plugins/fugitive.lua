vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

local function local_file_dir()
  local file_dir = vim.fn.expand '%:p:h'
  vim.cmd('lcd ' .. file_dir)
end
vim.keymap.set('n', '<leader>gs', function()
  local_file_dir()
  vim.cmd 'Git'
end, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gP', function()
  local_file_dir()

  vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
    if msg and msg ~= '' then
      vim.cmd 'Git add .'
      vim.cmd('Git commit -m ' .. vim.fn.shellescape(msg))
      vim.cmd 'Git push'
    end
  end)
end, { desc = 'Git add, commit, push' })
vim.keymap.set('n', '<leader>gc', function()
  local_file_dir()
  vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
    if msg and msg ~= '' then
      vim.cmd('Git commit -m ' .. vim.fn.shellescape(msg))
    end
  end)
end, { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gp', function()
  local_file_dir()
  vim.cmd 'Git push'
end, { desc = 'Git push' })
vim.keymap.set('n', '<leader>gl', function()
  local_file_dir()
  vim.cmd 'Git pull'
end, { desc = 'Git pull' })
vim.keymap.set('n', '<leader>gd', function()
  local_file_dir()
  vim.cmd 'Gvdiffsplit'
end, { desc = 'Git diff' })
vim.keymap.set('n', '<leader>ga', function()
  local_file_dir()
  vim.cmd 'Git add .'
end, { desc = 'Git add' })
vim.keymap.set('n', '<leader>gs', function()
  vim.ui.input({ prompt = 'Switch Branch: ' }, function(msg)
    if msg and msg ~= '' then
      vim.cmd("Git switch " .. msg)
      local exit_code = vim.v.shell_error

      if exit_code ~= 0 then
        -- Branch doesn't exist, create it
        vim.cmd("Git switch -c " .. msg)
        print("Created and switched to branch '" .. msg .. "'")
      else
        print("Switched to branch '" .. msg .. "'")
      end

      -- Refresh Fugitive so statusline updates
      vim.cmd("Git")
    end
  end)
end, { desc = 'Git switch branch' })
