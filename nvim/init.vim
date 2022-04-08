language C

if has('win64')
  "set shellslash
  let g:python3_host_prog='C:\Python39\python.exe'
endif

let s:config_dir = expand('~/.config/nvim')

" install vim-jetpack if it is not installed
if empty(glob(s:config_dir . '/autoload/jetpack.vim'))
  silent execute '!curl -fLo '.s:config_dir.'/autoload/jetpack.vim --create-dirs  https://raw.githubusercontent.com/tani/vim-jetpack/master/autoload/jetpack.vim'
endif

execute 'set runtimepath+='.s:config_dir

" Load plugins
autocmd VimEnter * JetpackSync | source $MYVIMRC
let g:jetpack#optimization = 1
runtime plugin.vim

runtime keymapping.vim

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
