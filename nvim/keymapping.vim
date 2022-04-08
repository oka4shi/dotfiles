noremap j gj
noremap k gk

nnoremap p ]p
nnoremap P ]P

nnoremap U <c-r>

nnoremap <c-w> <c-w>W

" using standard regex by default
nnoremap / /\v

augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup ENDx
