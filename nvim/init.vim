language C

if has('win64')
  "set shellslash
  let g:python3_host_prog='C:\Python39\python.exe'
endif

let s:config_dir = expand('~/.config/nvim')
let s:dein_toml =  expand('~/.config/nvim/dein.toml')
let s:dein_dir  = expand('~/dein')
let s:dein_repo_dir = expand('~/dein/repos/github.com/Shougo/dein.vim')

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_dir)
        echomsg 'dein.vim does not exists.'
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

execute 'set runtimepath+='.s:config_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#add(s:dein_repo_dir)

  call dein#load_toml(s:dein_toml, {'lazy': 0})
  "call dein#load_toml(s:dein_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
 
"call dein#call_hook('source')

if dein#check_install()
  call dein#install()
endif


" ---------- dein end ------------

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
