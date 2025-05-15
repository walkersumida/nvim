return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "eslint",
          "jsonls",
          "yamlls",
          "gopls",
          "ts_ls",
          "terraformls",
          "lua_ls",
          "pyright",
        },
        automatic_installation = true,
      })
    end,
  },
}
