local M = {}

function M.setup()
  -- Apply float window and LSP highlight settings
  vim.cmd([[
    augroup CustomHighlight
      autocmd!
      autocmd ColorScheme * highlight! FloatBorder guifg=#5E81AC guibg=NONE
      autocmd ColorScheme * highlight! NormalFloat guibg=#2E3440
      
      " LSP reference highlight
      autocmd ColorScheme * highlight! LspReferenceText guibg=#5E81AC
      autocmd ColorScheme * highlight! LspReferenceRead guibg=#5E81AC
      autocmd ColorScheme * highlight! LspReferenceWrite guibg=#5E81AC
    augroup END
    
    " Always clear highlight when switching windows (used in conjunction with per-buffer settings)
    augroup GlobalLspHighlightClear
      autocmd!
      autocmd WinEnter,WinLeave,BufEnter * lua vim.lsp.buf.clear_references()
    augroup END
    
    " Apply immediately
    highlight! FloatBorder guifg=#5E81AC guibg=NONE
    highlight! NormalFloat guibg=#2E3440
    highlight! LspReferenceText guibg=#5E81AC
    highlight! LspReferenceRead guibg=#5E81AC
    highlight! LspReferenceWrite guibg=#5E81AC
  ]])

  -- CursorLine and CursorColumn settings
  vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#2e2e2e" })

  vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1a4721" })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#5d1a1e" })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = "#382d0f" })
  vim.api.nvim_set_hl(0, "DiffText", { bg = "#4b3c0f" })

  -- GitSigns colors (GitGutter style)
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#009900" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffff00" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff2222" })
  vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#ff2222" })
  vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#ffff00" })
  vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#999999" })
end

return M
