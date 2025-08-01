return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_execute_on_save = false
    vim.g.db_ui_force_echo_notifications = true
    vim.g.db_ui_save_location = os.getenv("VIM_DADBOD_UI_PATH") or os.getenv("HOME") .. "/.local/share/vim-dadbod-ui/"
  end,
}
