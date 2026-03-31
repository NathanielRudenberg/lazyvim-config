return {
  -- Install codesettings.nvim
  {
    "mrjones2014/codesettings.nvim",
    -- opts = {
    --   jsonc_filetype = true,
    --   jsonls_integration = true,
    -- },
    -- ft = { "json", "jsonc", "lua" },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          before_init = function(_, config)
            require("codesettings").with_local_settings(config.name, config)
          end,
        },
      },
    },
  },
}
