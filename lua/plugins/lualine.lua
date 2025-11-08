return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "solarized_dark" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "filename" },
        lualine_c = { "branch", "diff", "diagnostics", "g:obsidian" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { "filename" },
        lualine_c = { "branch", "diff", "diagnostics" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
