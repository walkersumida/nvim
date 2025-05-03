local M = {}

function M.setup()
  vim.cmd("highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline")
  vim.cmd("highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline")
end

return M
