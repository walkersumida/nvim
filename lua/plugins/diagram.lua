return {
  {
    "3rd/diagram.nvim",
    dependencies = { "3rd/image.nvim" },
    ft = { "markdown" },
    opts = {
      -- diagram.nvim clears then re-renders (via mmdc) on every trigger without
      -- checking whether the content changed. Keeping InsertLeave here flickers the
      -- image every time you leave insert mode, so it is dropped and re-added
      -- (guarded on real changes) in the config function below.
      events = {
        render_buffer = { "TextChanged", "BufWinEnter", "WinEnter" },
      },
      renderer_options = {
        -- scale: resolution multiplier for the mmdc PNG output; higher = sharper when enlarged.
        mermaid = { theme = "forest", scale = 4 },
      },
    },
    config = function(_, opts)
      require("diagram").setup(opts)
      -- Re-render on InsertLeave only when the buffer actually changed during insert
      -- (record changedtick on enter, compare on leave) to avoid a no-op flicker.
      local grp = vim.api.nvim_create_augroup("DiagramInsertGuard", { clear = true })
      vim.api.nvim_create_autocmd("InsertEnter", {
        group = grp,
        callback = function(a)
          if vim.bo[a.buf].filetype ~= "markdown" then return end
          vim.b[a.buf].diagram_tick = vim.api.nvim_buf_get_changedtick(a.buf)
        end,
      })
      vim.api.nvim_create_autocmd("InsertLeave", {
        group = grp,
        callback = function(a)
          if vim.bo[a.buf].filetype ~= "markdown" then return end
          if vim.api.nvim_buf_get_changedtick(a.buf) ~= vim.b[a.buf].diagram_tick then
            require("diagram").render()
          end
        end,
      })
    end,
  },
}
