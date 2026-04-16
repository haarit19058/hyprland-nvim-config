-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Disable relative line numbers

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = false

-- Tab / indentation settings
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spaces inserted when hitting TAB
vim.opt.shiftwidth = 4 -- number of spaces for each indentation
vim.opt.expandtab = true -- convert TABs to spaces
vim.opt.smartindent = true -- auto indent new lines
