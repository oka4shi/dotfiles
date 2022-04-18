local function blend_bolor(fgcolor, bgcolor)
    local r = fgcolor[1] * fgcolor[4] + bgcolor[1] * (1 - fgcolor[4])
    local g = fgcolor[2] * fgcolor[4] + bgcolor[2] * (1 - fgcolor[4])
    local b = fgcolor[3] * fgcolor[4] + bgcolor[3] * (1 - fgcolor[4])
    return string.format("#%x%x%x", r, g, b)
end

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

vim.opt.termguicolors = true

local background = {25, 35, 48}

local indent_colors = {{255,255,64,0.1}, {127,255,127,0.1}, {255,127,255,0.1}, {79,236,236,0.1}}

vim.cmd [[highlight IndentBlanklineSpaceChar guifg=#666666 gui=nocombine]]

for i, color in ipairs(indent_colors) do
    local bg = blend_bolor(color, background)
    vim.cmd(string.format([[highlight IndentBlanklineIndent%s guifg=#666666 guibg=%s gui=nocombine]], i, bg))
end




require("indent_blankline").setup {
    space_char_blankline = "",
    char_blankline = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
    },
}

