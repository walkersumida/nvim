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

function! PreventOtherBuffersReplacingNERDTree()
  if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_tab_\d\+' && bufname('%') !~ 'NERD_tree_tab_\d\+' && winnr('$') > 1
    let buf = bufnr()
    execute 'buffer#'
    execute "normal! \<C-W>w"
    execute 'buffer' . buf
  endif
endfunction
autocmd BufEnter * call PreventOtherBuffersReplacingNERDTree()

""""""""""""""""""""""""""""""
" => bookmarks.nvim
""""""""""""""""""""""""""""""
lua << END
require('bookmarks').setup {
  -- sign_priority = 8,  --set bookmark sign priority to cover other sign
  save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
  keywords =  {
    ["@t"] = "✅", -- mark annotation startswith @t ,signs this icon as `Todo`
    ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
    ["@f"] = "🧰", -- mark annotation startswith @f ,signs this icon as `Fix`
    ["@n"] = "💬", -- mark annotation startswith @n ,signs this icon as `Note`
    ["@i"] = "💬", -- mark annotation startswith @i ,signs this icon as `Info`
  },
  on_attach = function(bufnr)
    local bm = require "bookmarks"
    local map = vim.keymap.set
    map("n","<leader>mm",bm.bookmark_ann) -- add or edit mark annotation at current line
    map("n","<leader>mt",bm.bookmark_toggle) -- add or remove bookmark at current line
    map("n","<leader>mc",bm.bookmark_clean) -- clean all marks in local buffer
    map("n","<leader>mn",bm.bookmark_next) -- jump to next mark in local buffer
    map("n","<leader>mp",bm.bookmark_prev) -- jump to previous mark in local buffer
    map("n","<leader>ml",bm.bookmark_list) -- show marked file list in quickfix window
    map("n","<leader>mx",bm.bookmark_clear_all) -- removes all bookmarks
  end
}
END

""""""""""""""""""""""""""""""
" => telescope.nvim
""""""""""""""""""""""""""""""
lua << END
local lga_actions = require("telescope-live-grep-args.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
        ["<C-f>"] = false,
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
      "node_modules/",
      ".git/",
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
          ["<C-i>"] = lga_actions.quote_prompt(),
        }
      }
    },
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
      no_ignore = true,
      hidden = { file_browser = true, folder_browser = true },
      mappings = {
        ["i"] = {
          ["<C-h>"] = false
        },
        ["n"] = {
          g = false,
          u = fb_actions.goto_parent_dir
        },
      },
    },
  }
}
require("telescope").load_extension("live_grep_args")
require('telescope').load_extension('bookmarks')
require("telescope").load_extension("file_browser")
END

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope git_status<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>fb :Telescope file_browser path=%:p:h select_buffer=true<cr>
nnoremap <leader>fm <cmd>Telescope bookmarks list<cr>
nnoremap <leader>k <cmd>Telescope commands<cr>
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
" => git-blame.nvim
""""""""""""""""""""""""""""""
lua << END
require('gitblame').setup {
    enabled = false,
}
END
let g:gitblame_date_format = '%Y-%m-%d %H:%M'

""""""""""""""""""""""""""""""
" => coc.nvim
""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
  \'coc-diagnostic', 
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
" => toggleterm.nvim
""""""""""""""""""""""""""""""
lua require("toggleterm").setup()

" For example: 2<C-t> will open terminal 2
nnoremap <leader>t <Cmd>exe v:count1 . "ToggleTerm"<CR>


""""""""""""""""""""""""""""""
" => vim-floaterm
""""""""""""""""""""""""""""""
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

nnoremap <silent> tt :FloatermToggle<cr>
nnoremap <silent> ta :FloatermNew<CR>
nnoremap <silent> tn :FloatermNext<CR>
nnoremap <silent> tp :FloatermPrev<CR>
nnoremap <silent> td :FloatermKill<CR>

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
" => baleia.nvim
" https://github.com/mfussenegger/nvim-dap/issues/1114#issuecomment-2407914108
""""""""""""""""""""""""""""""
lua << EOF
vim.g.baleia = require("baleia").setup({ })
vim.api.nvim_create_autocmd({ "FileType" }, {
   pattern = "dap-repl",
   callback = function()
      vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
   end,
})
EOF

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

""""""""""""""""""""""""""""""
" => quick-scope
""""""""""""""""""""""""""""""
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

""""""""""""""""""""""""""""""
" => nvim-treesitter
""""""""""""""""""""""""""""""
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "vim", "vimdoc", "markdown", "go" }
}
EOF

""""""""""""""""""""""""""""""
" => nvim-treesitter-context
""""""""""""""""""""""""""""""
lua << EOF
require'treesitter-context'.setup{}
EOF
""""""""""""""""""""""""""""""
" => neotest
""""""""""""""""""""""""""""""
lua << EOF
require("neotest").setup({
  adapters = {
    require("neotest-golang")
  }
})
EOF

command NeotestRun lua require("neotest").run.run()
command NeotestDebug lua require("neotest").run.run({suite = false, strategy = "dap"})
command NeotestOutput :Neotest output
command NeotestOutputPanel :Neotest output-panel
command NeotestSummary :Neotest summary

""""""""""""""""""""""""""""""
" => gitlinker
""""""""""""""""""""""""""""""
lua require('gitlinker').setup()
