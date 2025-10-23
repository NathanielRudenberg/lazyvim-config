-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- use json treesitter for jsonld files
vim.filetype.add({
  extension = {
    jsonld = "json",
  },
})

vim.treesitter.language.register("json", "json_ld")

-- enable clipboard
vim.opt.clipboard = "unnamedplus"

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
