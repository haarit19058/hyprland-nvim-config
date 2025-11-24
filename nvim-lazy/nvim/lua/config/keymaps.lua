-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
--
-- vim.keymap.set("i", "<C-S-x>", [[<Esc>:wq]], opts)
vim.keymap.set("i", "<C-x>", "<Esc><cmd>wq<cr>", opts)
vim.keymap.set("n", "<C-x>", "<cmd>wq<cr>", opts)
vim.keymap.set("v", "<C-x>", "<Esc><cmd>wq<cr>", opts)

-- SAVE: Ctrl + S
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>i", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>gv", { noremap = true, silent = true })
