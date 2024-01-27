""""""""""""""""""""""""""""""
" => Color scheme
""""""""""""""""""""""""""""""
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
