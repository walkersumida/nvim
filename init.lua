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
require("config.git-blame").setup()
require("config.nvim-dap").setup()
require("config.toggleterm").setup()
require("config.baleia").setup()
require("config.nvim-dap-ui").setup()
require("config.nvim-dap-go").setup()
require("config.nvim-dap-js").setup()
require("config.nvim-treesitter").setup()
require("config.wilder").setup()
require("config.gitgutter").setup()
require("config.vim-floaterm").setup()
require("config.vim-markdown").setup()
require("config.highlights").setup()
