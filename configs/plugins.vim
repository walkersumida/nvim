"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

map <leader>g :Ack ''<left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=1
let NERDTreeIgnore = []
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

" Quickly find and open a file in the current working directory
let g:ctrlp_map = '<C-f>'

" Quickly find and open a buffer
map <C-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

""""""""""""""""""""""""""""""
" => wilder (https://github.com/gelguy/wilder.nvim)
""""""""""""""""""""""""""""""
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'highlights': {
      \   'border': 'Normal',
      \ },
      \ 'border': 'rounded',
      \ 'pumblend': 20,
      \ })))

""""""""""""""""""""""""""""""
" => Buffer
""""""""""""""""""""""""""""""
" Close the current buffer
map <leader>bd :Bclose<cr>

""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
""""""""""""""""""""""""""""""
let g:gitgutter_enabled=1
highlight GitGutterAdd ctermfg=green ctermbg=darkgrey
highlight GitGutterChange ctermfg=yellow ctermbg=darkgrey
highlight GitGutterDelete ctermfg=red ctermbg=darkgrey

""""""""""""""""""""""""""""""
" => coc.nvim
""""""""""""""""""""""""""""""
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <C-m> coc#pum#visible() ? coc#pum#confirm() : "\<C-m>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType json let b:coc_suggest_disable = 1

""""""""""""""""""""""""""""""
" => vim-go
""""""""""""""""""""""""""""""
let g:go_doc_popup_window = 1

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
lua require("toggleterm").setup()

""""""""""""""""""""""""""""""
" => autoclose plugin
""""""""""""""""""""""""""""""
lua << END
require("autoclose").setup({
   keys = {
      ["$"] = { escape = true, close = true, disabled_filetypes = {} },
   },
})
END
