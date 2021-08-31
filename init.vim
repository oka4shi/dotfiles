set runtimepath+=~/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/dein')
  call dein#begin('~/dein')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" ---------- dein end ------------ 

set number

set updatetime=250

set autoindent
filetype plugin indent on
set expandtab

set hlsearch
set incsearch
set ignorecase
set smartcase

set encoding=UTF-8

" pair brackets hilight
set matchtime=0
set matchpairs& matchpairs+=<:>

" Ctrl+n: toggle file tree
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>
let g:fern#default_hidden=1
let g:fern#renderer = 'nerdfont'

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" color scheme settings
syntax enable
colorscheme codedark
let g:alrline_theme = 'codedark'

" Git changes
" gh: highlight diff
nnoremap gh :GitGutterLineHighlightsToggle<CR>
" gp: show diff
nnoremap gp :GitGutterPreviewHunk<CR>

highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red


let g:rainbow_active = 1
autocmd VimEnter * RainbowToggle
