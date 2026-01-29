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

" clipboard settings
" https://scrapbox.io/okashi-public/Neovim%E3%81%A7+%E3%83%AC%E3%82%B8%E3%82%B9%E3%82%BF%E3%81%AE%E5%86%85%E5%AE%B9%E3%81%8C%E3%81%86%E3%81%BE%E3%81%8F%E3%82%B3%E3%83%94%E3%83%BC%E3%81%95%E3%82%8C%E3%81%AA%E3%81%84
if $TMUX != ''
  let g:clipboard="tmux"
elseif $SSH_CONNECTION != ''
  let g:clipboard="osc52"
endif

let g:config_dir = expand('~/.config/nvim')

" install vim-jetpack if it is not installed
let s:jetpackfile = stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

" Automatic plugin installation
for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor


au FileType go setlocal sw=4 ts=4 sts=4 noet


" Load key mappings
runtime keymapping.lua
" Load XML tag completion
runtime xmltag.lua
" Load fold settings
runtime fold.lua

" Load plugins
runtime plugin.lua
runtime lsp.lua
