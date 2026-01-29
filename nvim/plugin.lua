vim.cmd('packadd vim-jetpack')
require('jetpack.packer').add {
    { 'tani/vim-jetpack' },
    -- Color scheme(nightfox)
    { 'EdenEast/nightfox.nvim',
        config = function()
            local groups = {
                all = {
                    -- disable italics
                    ["@text.literal"] = { style = "NONE" },
                    ["@text.uri"] = { style = "underline" },
                    -- ["@text.emphasis"] = { style = "NONE" },
                    ["@tag.attribute"] = { style = "NONE" }
                }
            }
            require('nightfox').setup({ groups = groups })
            vim.cmd('colorscheme nightfox')
        end
    },


    -- Airline
    { 'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'everforest',
                    component_separators = { left = '｜', right = '｜' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            path = 1
                        }
                    },
                    lualine_x = {'filetype'},
                    lualine_y = {},
                }
            })
        end
    },


    -- Fern.vim
    { 'lambdalisue/fern.vim',
        requires = {
            { 'lambdalisue/vim-glyph-palette' },
            { 'nvim-tree/nvim-web-devicons' },
            { 'TheLeoP/fern-renderer-web-devicons.nvim' },
            { 'lambdalisue/fern-git-status.vim' }
        },
        config = function()
            --Ctrl+n: toggle file tree
            vim.keymap.set('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>')

            -- Set icon
            vim.g['fern#renderer'] = 'nvim-web-devicons'

            -- Apply icon colors
            vim.fn['glyph_palette#apply']()
            vim.g['glyph_palette#palette'] = require 'fr-web-icons'.palette()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'fern',
                command = 'call glyph_palette#apply()'
            })

            -- Git status
            vim.g['fern_git_status#disable_ignored'] = 1

            -- Fix the fern buffer
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'fern',
                callback = function()
                    vim.opt_local.winfixbuf = true
                end
            })
        end
    },


    -- Telescope
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>f', builtin.find_files, {})
            vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>s', builtin.buffers, {})
            vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
        end
    },


    -- Colorizer
    { 'norcalli/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup({ '*' }, { css = true })
        end
    },

    { 'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })
                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', 'gp', gs.preview_hunk)
                end
            }
        end
    },


    -- Better syntax highlight
    { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "bash", "css", "csv", "diff", "dockerfile", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "html", "javascript", "json", "json5", "jsonc", "nim", "python", "regex", "ruby", "rust", "scss", "ssh_config", "svelte", "toml", "typescript", "xml", "yaml" },
                highlight = { enable = true }
            }
        end
    },

    -- Colorize brackets
    { 'hiphish/rainbow-delimiters.nvim' },

    -- Auto closing brackets
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    },


    -- Improved search label
    { 'kevinhwang91/nvim-hlslens',
        config = function()
            require('hlslens').setup()

            local kopts = { noremap = true, silent = true }

            vim.api.nvim_set_keymap('n', 'n',
                [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts)
            vim.api.nvim_set_keymap('n', 'N',
                [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts)
            vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

            vim.api.nvim_set_keymap('n', '<Leader>h', '<Cmd>noh<CR>', kopts)
        end
    },

    -- Cheetsheet
    { 'oka4shi/vim-cheatsheet',
        config = function()
            vim.g['cheatsheet#cheat_file'] = (vim.g.config_dir .. '/cheetsheet.md')

            vim.g['cheatsheet#float_window'] = 1
            vim.g['cheatsheet#float_window_width_ratio'] = 0.5
            vim.g['cheatsheet#float_window_height_ratio'] = 0.25
            vim.g['cheatsheet#float_window_blend_ratio'] = 30

            vim.keymap.set('n', '?', ':Cheat<CR>', {})
        end
    },


    -- Comment out at once
    { 'tomtom/tcomment_vim' },


    -- Vinary editor
    { 'RaafatTurki/hex.nvim',
        config = function() require 'hex'.setup() end
    },


    -- indent blankline
    { 'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("ibl").setup()
        end
    },

    -- Python Venv Slector(fd is needed)
    { 'linux-cultist/venv-selector.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
        -- event = 'VeryLazy',
        config = function()
            require('venv-selector').setup {
                name = { "venv", ".venv" }
            }

            vim.keymap.set('n', '<Leader>v', '<cmd>VenvSelect<CR>')
        end
    },

    -- Copilot
    { 'github/copilot.vim' },

    -- LSP
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/vim-vsnip",
}
