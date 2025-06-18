return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable only input and select UI improvements
      input = {
        enabled = true,
        win = {
          relative = "cursor",
          row = 1,
          col = 0,
        },
      },
      picker = { enabled = true },
      -- Disable all other features
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      gitbrowse = { enabled = false },
      lazygit = { enabled = false },
      notify = { enabled = false },
      quickfile = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
      win = { enabled = false },
      words = { enabled = false },
      zen = { enabled = false },
    },
  },
}
