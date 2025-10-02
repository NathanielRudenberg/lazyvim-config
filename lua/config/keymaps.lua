-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Enter normal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
map("n", "<leader>gg", ":Neogit<cr>", { desc = "Neogit (root)", noremap = true, silent = true })
map("n", "<leader>gG", ":Neogit cwd=<cwd><cr>", { desc = "Neogit (cwd)", noremap = true, silent = true })
map("n", "<leader><C-S>s", ":Store<cr>", { desc = "Open Plugin Store", noremap = true, silent = true })
