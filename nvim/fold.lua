function Foldtext()
    local line = vim.fn.getline(vim.v.foldstart)
    local count = vim.v.foldend - vim.v.foldstart + 1
    return string.format("%s (%d lines folded)", line, count)
end

vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.opt.foldtext = "v:lua.Foldtext()"
