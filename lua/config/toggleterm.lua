local M = {}

function M.setup()
  require("toggleterm").setup()
  vim.api.nvim_set_keymap('n', '<leader>t', ':lua vim.cmd(vim.v.count1 .. "ToggleTerm")<CR>',
    { noremap = true, silent = true })
end

return M
