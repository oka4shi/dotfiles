language C

set number
set signcolumn=yes

set updatetime=250

set smartindent
set autoindent
filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4

set hlsearch
set incsearch
set ignorecase
set smartcase

set encoding=UTF-8

syntax enable

" pair brackets hilight
set matchtime=0
set matchpairs& matchpairs+=<:>

" keymappings
"
noremap j gj
noremap k gk

nnoremap p ]p
nnoremap P ]P

" redo
nnoremap U <c-r>

nnoremap <c-w> <c-w>w

" close html tag
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup ENDx
