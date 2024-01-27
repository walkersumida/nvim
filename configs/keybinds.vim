""""""""""""""""""""""""""""""
" => Keybinds
""""""""""""""""""""""""""""""
nnoremap sh :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
inoremap <C-p> <C-c>gka
inoremap <C-n> <C-c>gja
noremap! <C-b> <Left>
noremap! <C-f> <Right>
noremap! <C-e> <End>
noremap! <C-a> <Home>
noremap! <C-d> <Del>
inoremap <C-l> <C-o>zz
noremap! <C-k> <c-o>D
noremap! <C-y> <C-r>"
vnoremap x "_x
nnoremap x "_x
inoremap jj <ESC>
nnoremap ZZ :qa<CR>

" Window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

""""""""""""""""""""""""""""""
" => Helper functions
""""""""""""""""""""""""""""""
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
