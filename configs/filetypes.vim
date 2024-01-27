""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""
let vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""
" => JSON section
""""""""""""""""""""""""""""""
" `brew install jq`
if executable('jq')
  autocmd FileType json autocmd BufWritePre <buffer> %!jq .
endif

