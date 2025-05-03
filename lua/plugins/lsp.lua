-- LSP関連のプラグイン設定

return {
  -- Basic LSP support (extending existing ones)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",       -- Completion from buffer
      "hrsh7th/cmp-path",         -- Path completion
      "hrsh7th/cmp-cmdline",      -- Command line completion
      "saadparwaiz1/cmp_luasnip", -- Snippet completion
    },
  },

  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets", -- Additional snippets
    },
  },

  -- Formatter and linter
  {
    "nvimtools/none-ls.nvim", -- Fork of null-ls
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Schema store (used for JSON and YAML completion)
  {
    "b0o/schemastore.nvim",
  },

  -- Display LSP progress
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}
