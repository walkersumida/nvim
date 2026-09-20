return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },

  opts = {
    file_types = { "markdown" },
    -- Tables are drawn by md-table-wrap.nvim.
    pipe_table = { enabled = false },
    -- render-markdown.nvim restores 'conceallevel' outside these modes, and
    -- md-table-wrap.nvim needs it above 0 to keep a table drawn.
    render_modes = { "n", "c", "t", "v", "V", "\22" },
  },
  ft = { "markdown" },
}
