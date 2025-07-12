local M = {}

function M.setup()
  -- Apply float window and LSP highlight settings
  vim.cmd([[
    augroup CustomHighlight
      autocmd!
      autocmd ColorScheme * highlight! FloatBorder guifg=#5E81AC guibg=NONE
      autocmd ColorScheme * highlight! NormalFloat guibg=#2E3440
      
      " LSP reference highlight
      autocmd ColorScheme * highlight! LspReferenceText guibg=#3B4252
      autocmd ColorScheme * highlight! LspReferenceRead guibg=#3B4252
      autocmd ColorScheme * highlight! LspReferenceWrite guibg=#3B4252
    augroup END
    
    " Always clear highlight when switching windows (used in conjunction with per-buffer settings)
    augroup GlobalLspHighlightClear
      autocmd!
      autocmd WinEnter,WinLeave,BufEnter * lua vim.lsp.buf.clear_references()
    augroup END
    
    " Apply immediately
    highlight! FloatBorder guifg=#5E81AC guibg=NONE
    highlight! NormalFloat guibg=#2E3440
    highlight! LspReferenceText guibg=#3B4252
    highlight! LspReferenceRead guibg=#3B4252
    highlight! LspReferenceWrite guibg=#3B4252
  ]])

  -- CursorLine and CursorColumn settings
  vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#2e2e2e" })
end

return M

