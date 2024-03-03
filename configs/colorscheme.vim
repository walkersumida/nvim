""""""""""""""""""""""""""""""
" => Color scheme
""""""""""""""""""""""""""""""
" Go syntax highlighting
autocmd ColorScheme * highlight goFuncDecl ctermfg=4 guifg=#000080
autocmd ColorScheme * highlight goNonPrimitiveType ctermfg=2 guifg=#008000
autocmd ColorScheme * highlight goPackageName ctermfg=2  guifg=#008000
autocmd ColorScheme * highlight goFuncBlock ctermfg=117 guifg=#9cdcfe
autocmd ColorScheme * highlight goFuncCallArgs ctermfg=117 guifg=#9cdcfe
autocmd ColorScheme * highlight goField ctermfg=117 guifg=#9cdcfe
autocmd ColorScheme * highlight goImportedPackages ctermfg=117 guifg=#9cdcfe
autocmd ColorScheme * highlight goSliceOrArrayType ctermfg=176 guifg=#c586c0
autocmd ColorScheme * highlight goBraces ctermfg=176 guifg=#c586c0
autocmd ColorScheme * highlight goStructLiteralBlock ctermfg=117 guifg=#9cdcfe
autocmd ColorScheme * highlight goStructLiteralField ctermfg=117 guifg=#9cdcfe
autocmd ColorScheme * highlight goFuncCallParens ctermfg=176 guifg=#c586c0

colorscheme codedark

""""""""""""""""""""""""""""""
" => Status line color
""""""""""""""""""""""""""""""
" require nerd-fonts
" https://github.com/ryanoasis/nerd-fonts
" And set your terminal font to nerd-fonts
lua << END
require('lualine').setup {
  options = { theme  = 'onedark' },
}
END

""""""""""""""""""""""""""""""
" => Helper functions
""""""""""""""""""""""""""""""
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()
