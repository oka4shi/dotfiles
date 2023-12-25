
require('jetpack.packer').startup(function(use)
    -- Color scheme(nightfox)
    use {'EdenEast/nightfox.nvim',
        config = function()
            vim.cmd('colorscheme nightfox')
        end
    }


    -- Airline
    use {'vim-airline/vim-airline'}
    use {'vim-airline/vim-airline-themes', requires = {'vim-airline/vim-airline'},
        config = function()
            vim.fn['airline#switch_theme']('deus')
        end
    }


    -- Fern.vim
    use {'lambdalisue/fern.vim',
        config = function()
            --Ctrl+n: toggle file tree
            vim.keymap.set('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>')
            vim.g['fern#default_hidden'] = 1
        end
    }


    use {'lambdalisue/nerdfont.vim'}
    use {'lambdalisue/fern-renderer-nerdfont.vim', requires = {'lambdalisue/nerdfont.vim', 'lambdalisue/fern.vim'},
        config = function()
            vim.g['fern#renderer'] = 'nerdfont'
        end
    }

    use {'lambdalisue/glyph-palette.vim', requires = {'lambdalisue/fern.vim', 'lambdalisue/fern-renderer-nerdfont.vim'},
        config = function()
            vim.api.nvim_create_autocmd('FileType',{
                pattern = 'fern',
                command = 'call glyph_palette#apply()'
            })
        end
    }

    use {'lambdalisue/fern-git-status.vim', requires = {'lambdalisue/nerdfont.vim', 'lambdalisue/fern.vim'},
        config = function()
            vim.g['fern_git_status#disable_ignored'] = 1
        end
    }


    -- Telescope
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = {'nvim-lua/plenary.nvim'},
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>f', builtin.find_files, {})
            vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>s', builtin.buffers, {})
            vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
        end
    }


    -- Colorizer
    use {'norcalli/nvim-colorizer.lua',
        config = function()
            require'colorizer'.setup({'*'}, {css = true})
        end
    }

    use {'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup{
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
                        end, {expr=true})
                    map('n', '[c', function()
                          if vim.wo.diff then return '[c' end
                              vim.schedule(function() gs.prev_hunk() end)
                              return '<Ignore>'
                          end, {expr=true})

                    map('n', 'gp', gs.preview_hunk)
                end
             }
        end
    }


    -- Better syntax highlight
    use {'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "astro", "bash" , "css", "csv", "diff", "dockerfile", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "html", "javascript", "json", "json5", "jsonc", "nim", "python", "regex", "rust", "scss", "ssh_config", "svelte", "toml", "typescript", "xml", "yaml"},
        highlight = { enable = true }
      }
    end
}

    -- Colorize brackets
    use {'hiphish/rainbow-delimiters.nvim'}

    -- Auto closing brackets
    use {
	"windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }


    -- Improved search label
    use {'kevinhwang91/nvim-hlslens',
        config = function()
            require('hlslens').setup()

            local kopts = {noremap = true, silent = true}

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
    }

    -- Cheetsheet
    use {'oka4shi/vim-cheatsheet',
        config = function()
            vim.g['cheatsheet#cheat_file'] = (vim.g.config_dir .. '/cheetsheet.md')

            vim.g['cheatsheet#float_window'] = 1
            vim.g['cheatsheet#float_window_width_ratio'] = 0.5
            vim.g['cheatsheet#float_window_height_ratio'] = 0.25
            vim.g['cheatsheet#float_window_blend_ratio'] = 30

            vim.keymap.set('n', '?', ':Cheat<CR>', {})
        end
    }


    -- Comment out at once
    use{'tomtom/tcomment_vim'}


    -- Vinary editor
    use {'Shougo/vinarise.vim'}


    -- indent blankline
    use {'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("ibl").setup()
        end
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    use'j-hui/fidget.nvim'

    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/vim-vsnip"

    use{ 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production', ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'}}

end)

-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
    local opt = {
    -- -- Function executed when the LSP server startup
    -- on_attach = function(client, bufnr)
    --   local opts = { noremap=true, silent=true }
    --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
    -- end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
    }
require('lspconfig')[server].setup(opt)
end })
require'lspconfig'.astro.setup{}

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>b', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {}
)

-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
]]
vim.api.nvim_create_augroup('lsp_document_highlight', {})
vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    group = 'lsp_document_highlight',
    callback = function () vim.lsp.buf.document_highlight() end

})
vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
    group = 'lsp_document_highlight',
    callback = function () vim.lsp.buf.clear_references() end

})

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        -- { name = "buffer" },
        -- { name = "path" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
    }),
    experimental = {
        ghost_text = true,
    },
})
