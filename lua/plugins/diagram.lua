return {
  {
    "3rd/diagram.nvim",
    dependencies = { "3rd/image.nvim" },
    ft = { "markdown" },
    opts = {
      events = {
        render_buffer = { "TextChanged", "BufWinEnter" },
        clear_buffer = {},
      },
      renderer_options = {
        -- scale: resolution multiplier for the mmdc PNG output; higher = sharper when enlarged.
        mermaid = { theme = "forest", scale = 4 },
      },
    },
    config = function(_, opts)
      require("diagram").setup(opts)
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
