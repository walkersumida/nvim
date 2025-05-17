return {
  -- Tools
  { "direnv/direnv.vim" },
  { "preservim/nerdtree" },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  { "tomasky/bookmarks.nvim" },
  { "simeji/winresizer" },
  { "tpope/vim-commentary" },
  { "airblade/vim-gitgutter" },
  { "yegappan/mru" },
  { "github/copilot.vim" },
  { "akinsho/toggleterm.nvim", version = "*" },
  { "voldikss/vim-floaterm" },
  { "guns/xterm-color-table.vim" },
  { "chrisbra/Colorizer" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  { "unblevable/quick-scope" },
  { "vim-test/vim-test" },
  { "dhruvasagar/vim-table-mode" },
  { "mbbill/undotree" },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
  { "nvim-neotest/nvim-nio" },
  { "m00qek/baleia.nvim" },

  -- Testing
  { "antoinemadec/FixCursorHold.nvim" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "fredrikaverpil/neotest-golang",
    version = "v1.10.2",
    dependencies = { "nvim-neotest/neotest" },
  },

  -- UI
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "nvim-tree/nvim-web-devicons" },

  -- Color scheme
  { "tomasiser/vim-code-dark" },

  -- Git
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "linrongbin16/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "f-person/git-blame.nvim" },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require("blame").setup({})
    end,
  },

  -- Go
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  { "charlespascoe/vim-go-syntax" },

  -- SQL
  { "mattn/vim-sqlfmt" },
  { "nanotee/sqls.nvim" },
  { "tpope/vim-dadbod" },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
  },

  -- Markdown
  { "preservim/vim-markdown" },

  -- Terraform
  { "hashivim/vim-terraform" },

  -- wilder
  {
    "gelguy/wilder.nvim",
    build = function()
      vim.cmd("UpdateRemotePlugins")
    end,
  },
}
