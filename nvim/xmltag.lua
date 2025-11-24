-- auto complete closing tag for xml, xslt, html files
local function complete_xml_close_tag()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row = cursor_pos[1]
    local col = cursor_pos[2]

    local text_before_cursor = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]:sub(1, col)
    vim.api.nvim_feedkeys("</", 'n', false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true), 'n', true)
    if string.gsub(text_before_cursor, "%s+", "") == "" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc><<i", true, false, true), 'n', true)
    end
end

_G.complete_xml_close_tag = complete_xml_close_tag

vim.api.nvim_create_augroup("XMLClose", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "xml", "xslt", "html" },
    group = "XMLClose",
    callback = function()
        vim.keymap.set("i", "</", complete_xml_close_tag, { buffer = true })
    end,
})
