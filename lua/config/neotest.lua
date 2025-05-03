local M = {}

function M.setup()
  require("neotest").setup({
    adapters = {
      require("neotest-golang")({
        go_test_args = { "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out" },
      })
    }
  })

  vim.api.nvim_create_user_command('NeotestRun', function()
    require("neotest").run.run()
  end, {})

  vim.api.nvim_create_user_command('NeotestDebug', function()
    require("neotest").run.run({ suite = false, strategy = "dap" })
  end, {})

  vim.api.nvim_create_user_command('NeotestOutput', function()
    vim.cmd('Neotest output')
  end, {})

  vim.api.nvim_create_user_command('NeotestOutputPanel', function()
    vim.cmd('Neotest output-panel')
  end, {})

  vim.api.nvim_create_user_command('NeotestSummary', function()
    vim.cmd('Neotest summary')
  end, {})
end

return M
