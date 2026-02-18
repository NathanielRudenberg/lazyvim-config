-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.number = true
-- vim.opt.statuscolumn = "%s %{v:relnum} %{v:lnum}"
vim.opt.relativenumber = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.opt.colorcolumn = "80" -- Highlight the 80th column

vim.cmd("highlight LeapBackdrop guifg=#777777")

vim.g.vimtex_compiler_out_dir = "./build"

vim.o.wrap = true
