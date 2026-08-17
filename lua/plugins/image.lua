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

      -- An image keeps the geometry recorded when it was drawn, so once the
      -- window's buffer becomes shorter than that line the renderer passes a
      -- non-existent line to screenpos() and aborts with E966. Skip such
      -- images; returning false runs image.nvim's usual clear path.
      local renderer = require("image/renderer")
      local original_render = renderer.render
      renderer.render = function(image)
        if image.window and vim.api.nvim_win_is_valid(image.window) then
          local buf = vim.api.nvim_win_get_buf(image.window)
          local y = image.geometry and image.geometry.y or 0
          if y + 1 > vim.api.nvim_buf_line_count(buf) then return false end
        end
        return original_render(image)
      end
    end,
  },
}
