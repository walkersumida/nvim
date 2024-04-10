""""""""""""""""""""""""""""""
" => general
""""""""""""""""""""""""""""""
set encoding=utf-8

" Register Leader
let mapleader = "\<Space>"

" Sets how many lines of history VIM has to remember
set history=500

" default time is 4000 ms = 4s
set updatetime=300

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * silent! checktime

" Save contents when <leader>w is pressed
nmap <leader>w :w!<cr>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

set splitright
set splitbelow

xnoremap p pgvy

" Execute a macro registered with qq
nmap <c-.> @q

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.config/nvim/tmp/undodir
    set undofile
catch
endtry

""""""""""""""""""""""""""""""
" => lang
""""""""""""""""""""""""""""""
lang en_US.UTF-8

""""""""""""""""""""""""""""""
" => Cursor section
""""""""""""""""""""""""""""""
set cursorline
highlight Cursorline cterm=bold

noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up>   gk

set whichwrap+=<,>,h,l

augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END

""""""""""""""""""""""""""""""
" => Clipboard section
""""""""""""""""""""""""""""""
set clipboard+=unnamed

""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

