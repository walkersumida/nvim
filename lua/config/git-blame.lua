local M = {}

function M.setup()
  require("gitblame").setup({})
  vim.g.gitblame_date_format = "%Y-%m-%d %H:%M"
end

return M
