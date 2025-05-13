return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter",
  },
  opts = {
    workspaces = {
      {
        name = "main",
        path = os.getenv("OBSIDIAN_WORKSPACE_PATH") or "",
      },
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show backlinks" })
  end,
}
