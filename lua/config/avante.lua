local M = {}

function M.setup()
  vim.keymap.set("n", "<leader>ac", "<cmd>AvanteClear<cr>")
  vim.keymap.set("n", "<leader>an", "<cmd>AvanteChatNew<cr>")
end

return M
