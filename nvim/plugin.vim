call jetpack#begin()

call jetpack#add('EdenEast/nightfox.nvim', {'tag': 'v1.0.0'})
autocmd! VimEnter * nested colorscheme nightfox

call jetpack#add('vim-airline/vim-airline')
call jetpack#add('vim-airline/vim-airline-themes')
autocmd VimEnter * AirlineTheme deus

call jetpack#add('lambdalisue/glyph-palette.vim')

call jetpack#add('lambdalisue/nerdfont.vim')

call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')

call jetpack#add('lambdalisue/fern-git-status.vim')

call jetpack#add('lambdalisue/fern.vim')
execute 'source '.expand('~/.config/nvim/plugins/fern.vim')

" Fuzzy finder
call jetpack#add('nvim-lua/plenary.nvim')
call jetpack#add('nvim-telescope/telescope.nvim', { 'rev': '0.1.1' })
nnoremap <Leader>f <cmd>Telescope find_files<CR>
nnoremap <Leader>tg <cmd>Telescope live_grep<cr>
nnoremap <Leader>s <cmd>Telescope buffers<cr>
nnoremap <Leader>th <cmd>Telescope help_tags<cr>

call jetpack#add('RRethy/vim-hexokinase', { 'do': 'make hexokinase' })
let g:Hexokinase_highlighters = [ 'virtual', 'backgroundfull' ]

call jetpack#add('lukas-reineke/indent-blankline.nvim')

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

call jetpack#add('goahi/vim-cheatsheet')
let g:cheatsheet#cheat_file = g:config_dir . '/cheetsheet.md'
let g:cheatsheet#float_window = 1
let g:cheatsheet#float_window_width_ratio = 0.5
let g:cheatsheet#float_window_height_ratio = 0.25
let g:cheatsheet#float_window_blend_ratio = 30
nnoremap ? :Cheat<CR>

call jetpack#add('Shougo/vinarise.vim')

call jetpack#add('andweeb/presence.nvim')

call jetpack#end()

execute 'source '.expand('~/.config/nvim/plugins/indent-blankline.lua')
