-- 1. LSP Sever management
require('mason').setup()
vim.lsp.enable(require('mason-lspconfig').get_installed_servers())

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K', vim.lsp.buf.hover, keyopts)
vim.keymap.set('n', '<Leader>b', vim.lsp.buf.format, keyopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, keyopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, keyopts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, keyopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, keyopts)
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, keyopts)
vim.keymap.set('n', 'gn', vim.lsp.buf.rename, keyopts)
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, keyopts)
vim.keymap.set('n', 'ge', vim.diagnostic.open_float, keyopts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, keyopts)
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, keyopts)



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

vim.api.nvim_create_autocmd('LspAttach', {
    -- Reference: https://blog.devoc.ninja/2025/nvim-v0-11-0-language-server-feature/
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method('textDocument/documentHighlight') then
            vim.api.nvim_create_augroup('lsp_document_highlight', {})
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                group = 'lsp_document_highlight',
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.document_highlight()
                end
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                group = 'lsp_document_highlight',
                callback = function() vim.lsp.buf.clear_references() end
            })
        end
    end
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
