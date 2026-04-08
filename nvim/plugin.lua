local gh = function(x)
    return "https://github.com/" .. x
end

-- Color scheme(nightfox)
vim.pack.add({gh("EdenEast/nightfox.nvim")})
require("nightfox").setup()
vim.cmd("colorscheme nightfox")

-- Airline
vim.pack.add({gh("nvim-lualine/lualine.nvim")})
require("lualine").setup(
    {
        options = {
            theme = "everforest",
            component_separators = {left = "｜", right = "｜"},
            section_separators = {left = "", right = ""}
        },
        sections = {
            lualine_c = {
                {
                    "filename",
                    path = 1
                }
            },
            lualine_x = {"filetype"},
            lualine_y = {}
        }
    }
)

-- Fern.vim
vim.pack.add(
    {
        gh("lambdalisue/vim-glyph-palette"),
        gh("nvim-tree/nvim-web-devicons"),
        gh("TheLeoP/fern-renderer-web-devicons.nvim"),
        gh("lambdalisue/fern-git-status.vim"),
        gh("lambdalisue/fern.vim")
    }
)
--Ctrl+n: toggle file tree
vim.keymap.set("n", "<C-n>", ":Fern . -reveal=% -drawer -toggle -width=40<CR>")

-- Set icon
vim.g["fern#renderer"] = "nvim-web-devicons"

-- Apply icon colors
vim.fn["glyph_palette#apply"]()
vim.g["glyph_palette#palette"] = require "fr-web-icons".palette()
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "fern",
        command = "call glyph_palette#apply()"
    }
)

-- Git status
vim.g["fern_git_status#disable_ignored"] = 1

-- Fix the fern buffer
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "fern",
        callback = function()
            vim.opt_local.winfixbuf = true
        end
    }
)

-- Telescope
vim.pack.add({gh("nvim-lua/plenary.nvim")})
vim.pack.add(
    {
        gh("nvim-lua/plenary.nvim"),
        gh("nvim-telescope/telescope.nvim")
    }
)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
vim.keymap.set("n", "<leader>s", builtin.buffers, {})
vim.keymap.set("n", "<leader>th", builtin.help_tags, {})

-- Colorizer
vim.pack.add({gh("catgoose/nvim-colorizer.lua")})
require "colorizer".setup({"*"}, {css = true})

vim.pack.add({gh("lewis6991/gitsigns.nvim")})
require("gitsigns").setup {
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)
        map("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        map("n", "gp", gitsigns.preview_hunk)
    end
}

-- Colorize brackets
vim.pack.add({gh("hiphish/rainbow-delimiters.nvim")})

-- Auto closing brackets
vim.pack.add({gh("windwp/nvim-autopairs")})
require("nvim-autopairs").setup {}

vim.pack.add({gh("kylechui/nvim-surround")})
require("nvim-surround").setup()

-- Improved search label
vim.pack.add({gh("kevinhwang91/nvim-hlslens")})
require("hlslens").setup()

local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap(
    "n",
    "n",
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts
)
vim.api.nvim_set_keymap(
    "n",
    "N",
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts
)
vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap("n", "<Leader>h", "<Cmd>noh<CR>", kopts)

-- Cheetsheet
vim.pack.add({gh("oka4shi/vim-cheatsheet")})
vim.g["cheatsheet#cheat_file"] = (vim.g.config_dir .. "/cheetsheet.md")

vim.g["cheatsheet#float_window"] = 1
vim.g["cheatsheet#float_window_width_ratio"] = 0.5
vim.g["cheatsheet#float_window_height_ratio"] = 0.25
vim.g["cheatsheet#float_window_blend_ratio"] = 30

vim.keymap.set("n", "?", ":Cheat<CR>", {})

-- Comment out at once
vim.pack.add({gh("tomtom/tcomment_vim")})

-- Vinary editor
vim.pack.add({gh("RaafatTurki/hex.nvim")})
require "hex".setup()

-- indent blankline
vim.pack.add({gh("lukas-reineke/indent-blankline.nvim")})
require("ibl").setup()

-- Python Venv Slector(fd is needed)
vim.pack.add(
    {
        gh("neovim/nvim-lspconfig"),
        gh("nvim-telescope/telescope.nvim"),
        gh("linux-cultist/venv-selector.nvim")
    }
)
require("venv-selector").setup {
    name = {"venv", ".venv"}
}

vim.keymap.set("n", "<Leader>v", "<cmd>VenvSelect<CR>")

-- Copilot
vim.pack.add({gh("github/copilot.vim")})

-- LSP
vim.pack.add({gh("neovim/nvim-lspconfig")})
vim.pack.add({gh("williamboman/mason.nvim")})
vim.pack.add({gh("williamboman/mason-lspconfig.nvim")})

vim.pack.add({gh("hrsh7th/nvim-cmp")})
vim.pack.add({gh("hrsh7th/cmp-nvim-lsp")})
vim.pack.add({gh("hrsh7th/vim-vsnip")})

