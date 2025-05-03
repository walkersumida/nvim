local M = {}

function M.setup()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "vim", "vimdoc", "markdown", "go" },
    sync_install = false,
    ignore_install = {},
    auto_install = false,
    modules = {},
  }
end

return M
