-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load basic configs before lazy setup
require("config.options").setup()

-- Load lazy.nvim plugins
require("lazy").setup("plugins")

-- Load configurations
require("config.colorscheme").setup()
require("config.keymaps").setup()
require("config.autocmds").setup()
require("config.buffer").setup()
require("config.commands").setup()
require("config.nerdtree").setup()
require("config.telescope").setup()
require("config.lsp").setup()
require("config.cmp").setup()
require("config.neotest").setup()
require("config.nvim-coverage").setup()
require("config.bookmarks").setup()
require("config.git-blame").setup()
require("config.nvim-dap").setup()
require("config.toggleterm").setup()
require("config.baleia").setup()
require("config.nvim-dap-ui").setup()
require("config.nvim-dap-go").setup()
require("config.lualine").setup()
require("config.nvim-treesitter").setup()
require("config.wilder").setup()
require("config.vim-dadbod-ui").setup()
require("config.gitgutter").setup()
require("config.quick-scope").setup()
require("config.vim-floaterm").setup()
require("config.vim-markdown").setup()

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
