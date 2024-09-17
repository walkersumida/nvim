""""""""""""""""""""""""""""""
" => vim-plug: https://github.com/junegunn/vim-plug
""""""""""""""""""""""""""""""
" :PlugInstall
call plug#begin()
    Plug 'direnv/direnv.vim'
    Plug 'preservim/nerdtree'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'nvim-telescope/telescope-live-grep-args.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    Plug 'simeji/winresizer'
    Plug 'tpope/vim-commentary'
    Plug 'airblade/vim-gitgutter'
    Plug 'yegappan/mru'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'github/copilot.vim'
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
    Plug 'voldikss/vim-floaterm'
    Plug 'guns/xterm-color-table.vim'
    Plug 'chrisbra/Colorizer'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'neovim/nvim-lspconfig'
    Plug 'unblevable/quick-scope'
    Plug 'vim-test/vim-test'
    Plug 'dhruvasagar/vim-table-mode'

    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui' " requires nvim-nio
    Plug 'nvim-neotest/nvim-nio'

    Plug 'antoinemadec/FixCursorHold.nvim'
    Plug 'nvim-neotest/neotest'
    Plug 'fredrikaverpil/neotest-golang', {'tag': 'v0.11.0'}

    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-tree/nvim-web-devicons'

    " Color scheme
    Plug 'tomasiser/vim-code-dark'

    " Git
    Plug 'rhysd/git-messenger.vim'
    Plug 'sindrets/diffview.nvim'
    Plug 'linrongbin16/gitlinker.nvim'
    Plug 'f-person/git-blame.nvim'
    " Go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'leoluz/nvim-dap-go'
    Plug 'charlespascoe/vim-go-syntax'
    " SQL
    Plug 'mattn/vim-sqlfmt'
    Plug 'nanotee/sqls.nvim'
    Plug 'tpope/vim-dadbod'
    Plug 'kristijanhusak/vim-dadbod-ui'
    " Markdown
    Plug 'preservim/vim-markdown'
    " Terraform
    Plug 'hashivim/vim-terraform'

    " wilder
    function! UpdateRemotePlugins(...)
      " Needed to refresh runtime files
      let &rtp=&rtp
      UpdateRemotePlugins
    endfunction
    Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
call plug#end()

source ~/.config/nvim/configs/basic.vim
source ~/.config/nvim/configs/colorscheme.vim
source ~/.config/nvim/configs/keybinds.vim
source ~/.config/nvim/configs/commands.vim
source ~/.config/nvim/configs/filetypes.vim
source ~/.config/nvim/configs/plugins.vim
