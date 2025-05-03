local M = {}

function M.setup()
  -- Normal mode
  vim.keymap.set('n', 'sh', ':<C-u>sp<CR>')
  vim.keymap.set('n', 'sv', ':<C-u>vs<CR>')
  vim.keymap.set('n', 'x', '"_x')
  vim.keymap.set('n', 'ZZ', ':qa<CR>')

  -- Insert mode
  vim.keymap.set('i', '<C-p>', '<C-c>gka')
  vim.keymap.set('i', '<C-n>', '<C-c>gja')
  vim.keymap.set('i', '<C-l>', '<C-o>zz')
  vim.keymap.set('i', 'jj', '<ESC>')

  -- Visual mode
  vim.keymap.set('v', 'x', '"_x')

  -- Insert + Command-line mode (noremap! 相当)
  vim.keymap.set({ 'i', 'c' }, '<C-b>', '<Left>')
  vim.keymap.set({ 'i', 'c' }, '<C-f>', '<Right>')
  vim.keymap.set({ 'i', 'c' }, '<C-e>', '<End>')
  vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>')
  vim.keymap.set({ 'i', 'c' }, '<C-d>', '<Del>')
  vim.keymap.set({ 'i', 'c' }, '<C-k>', '<C-o>D')
  vim.keymap.set({ 'i', 'c' }, '<C-y>', '<C-r>"')

  -- Window navigation (map → ノーマルモードで十分)
  vim.keymap.set('n', '<C-j>', '<C-W>j')
  vim.keymap.set('n', '<C-k>', '<C-W>k')
  vim.keymap.set('n', '<C-h>', '<C-W>h')
  vim.keymap.set('n', '<C-l>', '<C-W>l')
end

return M
