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
local lga_actions = require("telescope-live-grep-args.actions")
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
      }
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '-u'
    },
    file_ignore_patterns = {
      "node_modules",
      ".git",
      ".DS_Store",
      ".yarn"
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      sort_mru = true
    },
    find_files = {
      hidden = true
    }
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-'>"] = lga_actions.quote_prompt()
        }
      }
    },
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
      no_ignore = true,
      mappings = {
        ["i"] = {
        },
        ["n"] = {
        },
      },
    },
  }
}
require("telescope").load_extension("live_grep_args")
END

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb :lua require("telescope").extensions.file_browser.file_browser()<cr>
nnoremap <leader>fk <cmd>Telescope commands<cr>
nnoremap <leader>gg :lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>
nnoremap <Leader>gc <cmd>Telescope current_buffer_fuzzy_find<cr>
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
let g:coc_global_extensions = [
  \'coc-eslint', 
  \'coc-json',
  \'coc-prettier', 
  \'coc-tslint-plugin', 
  \'coc-tsserver', 
  \'coc-yaml'
\]

inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <C-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! ChoseAction(actions) abort
  echo join(map(copy(a:actions), { _, v -> v.text }), ", ") .. ": "
  let result = getcharstr()
  let result = filter(a:actions, { _, v -> v.text =~# printf(".*\(%s\).*", result)})
  return len(result) ? result[0].value : ""
endfunction

function! CocJumpAction() abort
  let actions = [
        \ {"text": "(h)orizontal split", "value": "split"},
        \ {"text": "(v)ertical split", "value": "vsplit"},
        \ {"text": "(t)ab", "value": "tabedit"},
        \ ]
  return ChoseAction(actions)
endfunction

" Use <C-]> to choose whether to open in a new window, in a tab, or in the current window when jumping definitions.
nnoremap <silent> <C-]> :<C-u>call CocActionAsync('jumpDefinition', CocJumpAction())<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType json let b:coc_suggest_disable = 1

autocmd BufWritePre *.tfvars call CocActionAsync('format')
autocmd BufWritePre *.tf call CocActionAsync('format')

""""""""""""""""""""""""""""""
" => vim-go
""""""""""""""""""""""""""""""
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_textobj_enabled = 0
" let g:go_diagnostics_level = 2

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>fh :MRU<CR>

""""""""""""""""""""""""""""""
" => vim-floaterm
""""""""""""""""""""""""""""""
map <silent><c-t> :FloatermToggle<cr>

""""""""""""""""""""""""""""""
" => git-messenger.vim
""""""""""""""""""""""""""""""
let g:git_messenger_no_default_mappings = v:true
nmap <C-w>m <Plug>(git-messenger)

""""""""""""""""""""""""""""""
" => nvim-dap
""""""""""""""""""""""""""""""
lua require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } })
map <leader>dj :lua require('dap').step_over()<CR>
map <leader>dl :lua require('dap').step_into()<CR>
map <leader>dp :lua require('dap').toggle_breakpoint()<CR>
map <leader>dc :lua require('dap').continue()<CR>

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
map <leader>dk :lua require('dapui').eval()<CR>
command DapUIOpen lua require'dapui'.open()
command DapUIClose lua require'dapui'.close()

""""""""""""""""""""""""""""""
" => nvim-dap-go
""""""""""""""""""""""""""""""
lua require('dap-go').setup()

""""""""""""""""""""""""""""""
" => lualine
""""""""""""""""""""""""""""""
lua << EOF
require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {'branch', 'diff', 'diagnostics'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {'filename'},
    lualine_c = {'branch', 'diff', 'diagnostics'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}
EOF
