local M = {}

function M.setup()
  vim.g.floaterm_width = 0.8
  vim.g.floaterm_height = 0.8

  vim.api.nvim_set_keymap('n', 'tt', ':FloatermToggle<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'ta', ':FloatermNew<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'tn', ':FloatermNext<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'tp', ':FloatermPrev<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'td', ':FloatermKill<CR>', { noremap = true, silent = true })
end

return M
