local M = {}

function M.setup()
  local dap = require("dap")

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
      args = { "${port}" },
    },
  }

  dap.adapters["pwa-chrome"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
      args = { "${port}" },
    },
  }

  dap.adapters["node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
      args = { "${port}" },
    },
  }
end

return M
