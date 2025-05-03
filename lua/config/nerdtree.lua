local M = {}

function M.setup()
  -- NERDTree global settings
  vim.g.NERDTreeWinPos = 'left'
  vim.g.NERDTreeShowHidden = 1
  vim.g.NERDTreeIgnore = {}
  vim.g.NERDTreeWinSize = 35

  -- keymaps
  vim.keymap.set('n', '<leader>nn', ':NERDTreeToggle<CR>')
  vim.keymap.set('n', '<leader>nb', ':NERDTreeFromBookmark ')
  vim.keymap.set('n', '<leader>nf', ':NERDTreeFind<CR>')

  -- autocmd to prevent other buffers replacing NERDTree
  local function prevent_other_buffers_replacing_nerdtree()
    local current_win = vim.fn.winnr()
    local alt_win = vim.fn.winnr('h')
    local alt_bufname = vim.fn.bufname('#')
    local curr_bufname = vim.fn.bufname('%')
    if current_win == alt_win
        and alt_bufname:match('NERD_tree_tab_%d+')
        and not curr_bufname:match('NERD_tree_tab_%d+')
        and vim.fn.winnr('$') > 1
    then
      local buf = vim.fn.bufnr()
      vim.cmd('buffer#')
      vim.cmd('normal! <C-W>w')
      vim.cmd('buffer ' .. buf)
    end
  end

  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = prevent_other_buffers_replacing_nerdtree,
  })
end

return M
