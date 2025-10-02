return {
  "NeogitOrg/neogit",
  config = function()
    require("neogit").setup({
      kind = "floating",
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
      integrations = { diffview = true }, -- adds integration with diffview.nvim
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed.
    "ibhagwan/fzf-lua", -- optional
  },
}
