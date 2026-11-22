local gh = function(x)
    return "https://github.com/" .. x
end

-- build hook
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name ~= 'nvim-treesitter' then return end
        if kind ~= 'install' and kind ~= 'update' then return end

        vim.cmd('TSUpdate')
    end,
})
vim.pack.add({
    gh("nvim-treesitter/nvim-treesitter"),
})


require('nvim-treesitter').setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install { 
   "c",
   "lua",
   "vim",
   "vimdoc",
   "query",
   "bash",
   "css",
   "csv",
   "diff",
   "dockerfile",
   "git_config",
   "git_rebase",
   "gitattributes",
   "gitcommit",
   "gitignore",
   "go",
   "gomod",
   "gosum",
   "html",
   "javascript",
   "json",
   "json5",
   "python",
   "r",
   "regex",
   "ruby",
   "rust",
   "scss",
   "ssh_config",
   "svelte",
   "toml",
   "tsx",
   "typescript",
   "xml",
   "yaml"
}

-- enable treesitter in all file types
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
