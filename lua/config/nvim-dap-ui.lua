local M = {}

function M.setup()
  require('dapui').setup()
  require 'dap'.listeners.before['event_initialized']['custom'] = function(session, body)
    require 'dapui'.open()
  end
  require 'dap'.listeners.before['event_terminated']['custom'] = function(session, body)
    require 'dapui'.close()
  end
  vim.api.nvim_set_keymap('n', '<leader>dk', ":lua require('dapui').eval()<CR>", { noremap = true, silent = true })
  vim.api.nvim_create_user_command('DapUIOpen', "lua require('dapui').open()", {})
  vim.api.nvim_create_user_command('DapUIClose', "lua require('dapui').close()", {})
end

return M
