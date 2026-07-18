local M = {}

function M.setup()
  local ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
    "go",
    "typescript",
    "javascript",
    "tsx",
    "sql",
  }

  -- Install only the parsers that are missing (compiled locally, async).
  local ok, cfg = pcall(require, "nvim-treesitter.config")
  local installed = ok and cfg.get_installed() or {}
  local to_install = vim.tbl_filter(function(p)
    return not vim.tbl_contains(installed, p)
  end, ensure_installed)
  if #to_install > 0 then
    require("nvim-treesitter").install(to_install)
  end

  -- Enable treesitter highlighting per filetype.
  -- sql is intentionally excluded (kept on vim regex syntax, matching the old `disable = { "sql" }`).
  local skip = { sql = true }
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
    callback = function(args)
      if skip[vim.bo[args.buf].filetype] then
        return
      end
      pcall(vim.treesitter.start)
    end,
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
