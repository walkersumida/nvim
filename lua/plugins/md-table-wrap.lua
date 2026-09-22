return {
  {
    "walkersumida/md-table-wrap.nvim",
    ft = "markdown",
    opts = {},
    keys = {
      {
        "<leader>mt",
        function()
          require("md-table-wrap").open_float()
        end,
        ft = "markdown",
        desc = "Open the markdown table in a float",
      },
    },
  },
}
