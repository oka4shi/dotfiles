vim.g.mapleader = " "

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "p", "]p")
vim.keymap.set("n", "P", "[p")

-- paste from a clip board
vim.keymap.set("n", "<Leader>p", "\"+p", { remap = true })
vim.keymap.set("n", "<Leader>P", "\"+P", { remap = true })

-- yank to a clip board
vim.keymap.set("n", "<Leader>yy", "\"+yy")
vim.keymap.set("v", "<Leader>y", "\"+y")

-- redo with U
vim.keymap.set("n", "U", "<c-r>")

-- move to previous buffer by default
vim.keymap.set("n", "<c-w>", "<c-w>W")

-- using standard regex by default
vim.keymap.set("n", "/", "/\\v")

-- toggle line number display
vim.keymap.set("n", "<Leader>l", ":set number!<CR>")

-- foldings
vim.keymap.set("n", "<Tab>", "za")
vim.keymap.set("n", "<Leader><Tab>", "zR")
