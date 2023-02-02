let mapleader = "\<Space>"

noremap j gj
noremap k gk

nnoremap p ]p
nnoremap P [p
" paste from a clip board
nmap <Leader>p "+p
nmap <Leader>P "+P

" yank to a clip board
nnoremap <Leader>yy "+yy
vnoremap <Leader>y "+y

nnoremap U <c-r>

nnoremap <c-w> <c-w>W

" using standard regex by default
nnoremap / /\v

augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup ENDx

" toggle line number display
nnoremap <Leader>l :set number!<CR>

