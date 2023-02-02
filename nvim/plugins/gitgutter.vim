" gp: show diff
nnoremap gp :GitGutterPreviewHunk<CR>

let g:gitgutter_sign_added = '＋'
let g:gitgutter_sign_modified = '～'
let g:gitgutter_sign_removed = '－'
let g:gitgutter_sign_column_always = 1


let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn ctermbg=240

autocmd ColorScheme * highlight GitGutterAdd ctermfg=255 ctermbg=64 guifg=#ffffff guibg=#4b5632
autocmd ColorScheme * highlight GitGutterChange ctermfg=255 ctermbg=32 guifg=#ffffff guibg=#0087d7
autocmd ColorScheme * highlight GitGutterDelete ctermfg=255 ctermbg=124 guifg=#ffffff guibg=#4b1818

autocmd ColorScheme * highlight GitGutterAddLine ctermfg=64 guifg=#4b5632
autocmd ColorScheme * highlight GitGutterChangeLine ctermfg=32 guifg=#0087d7
autocmd ColorScheme * highlight GitGutterDeleteLine ctermfg=124 guifg=#4b1818

