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
        -- Temporarily disable OptionSet events to prevent treesitter fold errors
        local saved = vim.o.eventignore
        vim.o.eventignore = "OptionSet"
        require("dbee").toggle()
        vim.defer_fn(function() vim.o.eventignore = saved end, 50)
      end, { desc = "Toggle DBee" })
    end,
  },
}
