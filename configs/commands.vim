""""""""""""""""""""""""""""""
" => Commands
""""""""""""""""""""""""""""""
command CopyFilePath let @* = expand('%:p')
command CopyPath let @* = expand('%:h')
command CopyFileName let @* = expand('%:t')
command EncodeSJIS e ++enc=sjis
command SaveWithoutFormatting noa w
