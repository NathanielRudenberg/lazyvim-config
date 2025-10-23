-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Enter normal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Neogit
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit (root)", noremap = true, silent = true })
map("n", "<leader>gG", "<cmd>Neogit cwd=<cwd><cr>", { desc = "Neogit (cwd)", noremap = true, silent = true })

-- Plugin store
map("n", "<leader><C-S>s", "<cmd>Store<cr>", { desc = "Open Plugin Store", noremap = true, silent = true })

-- Diffview
map("n", "<leader>gd", function()
  if next(require("diffview.lib").views) == nil then
    vim.cmd("DiffviewOpen")
  else
    vim.cmd("DiffviewClose")
  end
end, { desc = "Open Diffview" })
