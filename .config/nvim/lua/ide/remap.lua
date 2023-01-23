vim.g.mapleader = " "

-- move block of code up and down with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--pasting to system clipboard with leader y
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

--remove capital Q
vim.keymap.set("n","Q","<nop>")

--format json
vim.keymap.set("n","<leader>js", [[:%!python -m json.tool<CR>]],{})

--shift tab reverse tab
vim.keymap.set("n", "<S-Tab>", "<<")
vim.keymap.set("v", "<S-Tab>", "<<")
vim.keymap.set("i", "<S-Tab>", "<C-d>")
