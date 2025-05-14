local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "vim", "vimdoc", "markdown", "markdown_inline", "go" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" },
    },
    sync_install = false,
    ignore_install = {},
    auto_install = false,
    modules = {},
  })
end

return M
