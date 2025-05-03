local M = {}

function M.setup()
  vim.api.nvim_create_user_command('CopyFilePath', function()
    vim.fn.setreg('*', vim.fn.expand('%:p'))
  end, {})

  vim.api.nvim_create_user_command('CopyPath', function()
    vim.fn.setreg('*', vim.fn.expand('%:h'))
  end, {})

  vim.api.nvim_create_user_command('CopyFileName', function()
    vim.fn.setreg('*', vim.fn.expand('%:t'))
  end, {})

  vim.api.nvim_create_user_command('EncodeSJIS', function()
    vim.cmd('e ++enc=sjis')
  end, {})

  vim.api.nvim_create_user_command('SaveWithoutFormatting', function()
    vim.cmd('noa w')
  end, {})
end

return M
