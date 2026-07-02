return {
  {
    "3rd/image.nvim",
    ft = { "markdown" },
    opts = {
      -- Auto-clear/redraw images so they don't linger in inactive tmux windows.
      -- Requires `focus-events on` + `visual-activity off` in tmux.conf.
      tmux_show_only_in_active_window = true,
      -- Max on-screen display size (in cells); larger values show bigger diagrams.
      max_width = 150,
      max_height = 50,
    },
  },
}
