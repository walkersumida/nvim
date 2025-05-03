local M = {}

function M.setup()
  -- https://github.com/mfussenegger/nvim-dap/issues/1114#issuecomment-2407914108
  vim.g.baleia = require("baleia").setup({})
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "dap-repl",
    callback = function()
      vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
    end,
  })
end

return M
