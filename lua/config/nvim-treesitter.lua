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

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local pink = "#BC89BD"
      local purple = "#CB76D0"
      local blue = "#829EB4"
      local yellow = "#DCDCAF"
      vim.api.nvim_set_hl(0, "@keyword.return", { fg = pink })
      vim.api.nvim_set_hl(0, "@keyword.conditional", { fg = pink })
      vim.api.nvim_set_hl(0, "@keyword.repeat", { fg = pink })
      vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = purple })
      vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = blue })
      vim.api.nvim_set_hl(0, "@constructor.go", { fg = yellow })
    end,
  })
end

return M
