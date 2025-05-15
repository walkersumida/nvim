return {
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    ft = "python",
    config = function()
      local cwd = vim.fn.getcwd()
      local handle = io.popen("cd " .. cwd .. " && poetry run which python")
      local result = handle:read("*a")
      handle:close()
      local python_path = result:gsub("%s+", "")

      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      dap_python.setup(python_path)

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
