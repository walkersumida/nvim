local M = {}

function M.setup()
  -- Filetype plugins
  vim.cmd('filetype plugin on')
  vim.cmd('filetype indent on')

  -- Auto check for file changes
  vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
    pattern = '*',
    command = 'silent! checktime',
  })

  -- Restore cursor position when reopening file
  vim.api.nvim_create_augroup('vimrcEx', { clear = true })
  vim.api.nvim_create_autocmd('BufReadPost', {
    group = 'vimrcEx',
    callback = function()
      local line = vim.fn.line([['"]])
      if line > 1 and line <= vim.fn.line('$') then
        vim.cmd('normal! g`"')
      end
    end,
  })
end

return M
