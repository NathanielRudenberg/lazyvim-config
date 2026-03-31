return {
  {
    "https://github.com/navarasu/onedark.nvim",
    opts = {
      style = "darker",
    },
  },
  { "martinsione/darkplus.nvim" },
  { "askfiy/visual_studio_code" },
  { "Mofiqul/vscode.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine" },
  { "rebelot/kanagawa.nvim" },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
  },
  { "projekt0n/github-nvim-theme", name = "github-theme" },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin-mocha",
      -- colorscheme = "vscode",
      -- colorscheme = "rose-pine",
      colorscheme = "github_dark_dimmed",
    },
  },
}
