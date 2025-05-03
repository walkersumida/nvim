local M = {}

function M.setup()
  vim.g.gitgutter_enabled = 1
  vim.cmd('highlight GitGutterAdd ctermfg=green ctermbg=darkgrey')
  vim.cmd('highlight GitGutterChange ctermfg=yellow ctermbg=darkgrey')
  vim.cmd('highlight GitGutterDelete ctermfg=red ctermbg=darkgrey')
end

return M
