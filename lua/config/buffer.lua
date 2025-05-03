local M = {}

function M.setup()
  vim.api.nvim_create_user_command('Bclose', function()
    local current_buf = vim.fn.bufnr('%')
    local alternate_buf = vim.fn.bufnr('#')

    if vim.fn.buflisted(alternate_buf) == 1 then
      vim.cmd('buffer #')
    else
      vim.cmd('bnext')
    end

    if vim.fn.bufnr('%') == current_buf then
      vim.cmd('new')
    end

    if vim.fn.buflisted(current_buf) == 1 then
      vim.cmd('bdelete! ' .. current_buf)
    end
  end, {})
  vim.keymap.set('n', '<leader>bd', ':Bclose<CR>')
end

return M
