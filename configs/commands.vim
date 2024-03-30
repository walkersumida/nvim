""""""""""""""""""""""""""""""
" => Commands
""""""""""""""""""""""""""""""
command PasteCurBufFilePathToClip let @* = expand('%:p')
command PasteCurBufPathToClip let @* = expand('%:h')
command PasteCurBufFileNameToClip let @* = expand('%:t')
command EncodeSJIS e ++enc=sjis
command SaveWithoutFormatting noa w
