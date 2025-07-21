return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup()
      vim.keymap.set("n", "<leader>ss", function()
        require("dbee").toggle()
      end, { desc = "Toggle DBee" })
    end,
  },
}
