return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
    },
    sources = {
      -- default = { "lsp", "path", "buffer", "snippets", "minuet" },
      default = { "lsp", "path", "buffer", "snippets" },
      providers = {
        -- minuet = {
        --   name = "minuet",
        --   module = "minuet.blink",
        --   async = true,
        --   -- timeout_ms = 3000, -- matches minuet request_timeout (3s) * 1000
        --   score_offset = 50, -- higher priority among suggestions
        -- },
      },
    },
    -- Recommended to avoid unnecessary requests
    completion = {
      trigger = { prefetch_on_insert = false },
      ghost_text = {
        enabled = true,
      },
    },
  },
}
