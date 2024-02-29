""""""""""""""""""""""""""""""
" => vim-plug: https://github.com/junegunn/vim-plug
""""""""""""""""""""""""""""""
" :PlugInstall
call plug#begin()
    Plug 'mileszs/ack.vim'
    Plug 'direnv/direnv.vim'
    Plug 'preservim/nerdtree'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'simeji/winresizer'
    Plug 'tpope/vim-commentary'
    Plug 'airblade/vim-gitgutter'
    Plug 'yegappan/mru'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'github/copilot.vim'
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
    Plug 'm4xshen/autoclose.nvim'

    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-tree/nvim-web-devicons'

    " Color scheme
    Plug 'tomasiser/vim-code-dark'

    " Go
    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'leoluz/nvim-dap-go'
    " SQL
    Plug 'mattn/vim-sqlfmt'
    Plug 'nanotee/sqls.nvim'
    Plug 'tpope/vim-dadbod'
    Plug 'kristijanhusak/vim-dadbod-ui'
    " Markdown
    Plug 'preservim/vim-markdown'

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
