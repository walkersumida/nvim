local M = {}

function M.setup()
  require('dap.ext.vscode').load_launchjs(nil, { cpptools = { "c", "cpp" } })
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  map('n', '<leader>dj', ":lua require('dap').step_over()<CR>", opts)
  map('n', '<leader>dl', ":lua require('dap').step_into()<CR>", opts)
  map('n', '<leader>dp', ":lua require('dap').toggle_breakpoint()<CR>", opts)
  map('n', '<leader>dc', ":lua require('dap').continue()<CR>", opts)
end

return M
