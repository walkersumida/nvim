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
    config = function(_, opts)
      require("image").setup(opts)
      -- In tmux the reported winsize pixel dimensions are smaller than iTerm2's real
      -- cell size, so image.nvim draws diagrams too small and leaves a gap below.
      -- Force the real cell size (measured with :luafile /tmp/diag_cellsize.lua outside
      -- tmux) only while inside tmux. Adjust the numbers if the image is too big/small.
      if vim.env.TMUX then
        -- NOTE: image.nvim requires this module with a slash path internally
        -- (require("image/utils").term); the dot path is a *different* cached
        -- instance and would not affect the renderer. Match the slash path.
        local term = require("image/utils").term
        local orig_get_size = term.get_size
        term.get_size = function()
          local s = orig_get_size()
          if s then
            s.cell_width = 22
            s.cell_height = 42
            s.screen_x = s.cell_width * s.screen_cols
            s.screen_y = s.cell_height * s.screen_rows
          end
          return s
        end
      end
    end,
  },
}
