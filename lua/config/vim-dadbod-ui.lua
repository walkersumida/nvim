local M = {}

function M.setup()
  vim.g.db_ui_force_echo_notifications = true
  vim.g.db_ui_save_location = os.getenv("VIM_DADBOD_UI_PATH") or os.getenv("HOME") .. '/.local/share/vim-dadbod-ui/'
end

return M
