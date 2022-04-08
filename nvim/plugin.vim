call jetpack#begin()

call jetpack#add('tomasiser/vim-code-dark')
autocmd! VimEnter * nested colorscheme codedark

call jetpack#add('vim-airline/vim-airline')
let g:alrline_theme = 'codedark'

call jetpack#add('lambdalisue/glyph-palette.vim')

call jetpack#add('lambdalisue/nerdfont.vim')

call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')

call jetpack#add('lambdalisue/fern-git-status.vim')

call jetpack#add('lambdalisue/fern.vim')
execute 'source '.expand('~/.config/nvim/plugins/fern.vim')

call jetpack#add('tomtom/tcomment_vim')

call jetpack#add('airblade/vim-gitgutter')
execute 'source '.expand('~/.config/nvim/plugins/gitgutter.vim')

call jetpack#add('cohama/lexima.vim')

call jetpack#add('luochen1990/rainbow')
let g:rainbow_active = 1
autocmd VimEnter * RainbowToggle

call jetpack#add('neoclide/coc.nvim', { 'branch': 'release' })
execute 'source '.expand('~/.config/nvim/plugins/coc.vim')

"syntax highlight for svelte
call jetpack#add('evanleck/vim-svelte')

call jetpack#add('reireias/vim-cheatsheet')
let g:cheatsheet#float_window = 1
let g:cheatsheet#float_window_width_ratio = 0.5
let g:cheatsheet#float_window_height_ratio = 0.25
nnoremap ? :Cheat<CR>

call jetpack#end()
