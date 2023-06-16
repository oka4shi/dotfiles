language C

if has('win64')
  "set shellslash
  let g:python3_host_prog='C:\Python39\python.exe'
endif

set number
set signcolumn=yes
set pumblend=25
set termguicolors

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

runtime keymapping.vim

let g:config_dir = expand('~/.config/nvim')

" install vim-jetpack if it is not installed
let s:jetpackfile = g:config_dir .. '/autoload/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"

if empty(glob(g:config_dir . '/autoload/jetpack.vim'))
    echo "Installing jetpack..."
    call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

execute 'set runtimepath+='.g:config_dir

" Automatic plugin installation
let g:jetpack#optimization = 1
for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor


au FileType go setlocal sw=4 ts=4 sts=4 noet


" Load plugins
runtime plugin.lua
