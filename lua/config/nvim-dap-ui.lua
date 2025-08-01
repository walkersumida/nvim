local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  vim.keymap.set("n", "<leader>du", dapui.toggle, { silent = true, desc = "Toggle DAP UI" })
  vim.api.nvim_set_keymap("n", "<leader>dk", ":lua require('dapui').eval()<CR>", { noremap = true, silent = true })
  vim.api.nvim_create_user_command("DapUIOpen", dapui.open, { desc = "Open DAP UI" })
  vim.api.nvim_create_user_command("DapUIClose", dapui.close, { desc = "Close DAP UI" })
end

return M
