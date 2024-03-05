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
" => telescope.nvim
""""""""""""""""""""""""""""""
lua << END
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
      }
    }
  }
}
END

nnoremap <C-f><C-f> <cmd>Telescope find_files<cr>
nnoremap <C-f><C-k> <cmd>Telescope commands<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>

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
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <C-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType json let b:coc_suggest_disable = 1

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
lua require("toggleterm").setup()

nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

""""""""""""""""""""""""""""""
" => git-messenger.vim
""""""""""""""""""""""""""""""
let g:git_messenger_no_default_mappings = v:true
nmap <C-w>m <Plug>(git-messenger)

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

""""""""""""""""""""""""""""""
" => nvim-dap-ui
""""""""""""""""""""""""""""""
lua << EOF
  require('dapui').setup()
  require'dap'.listeners.before['event_initialized']['custom'] = function(session, body)
    require'dapui'.open()
  end
  require'dap'.listeners.before['event_terminated']['custom'] = function(session, body)
    require'dapui'.close()
  end
EOF

""""""""""""""""""""""""""""""
" => nvim-dap-go
""""""""""""""""""""""""""""""
lua require('dap-go').setup()
