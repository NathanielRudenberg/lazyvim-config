return {
  "yetone/avante.nvim",
  opts = {
    provider = "claude",
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        auth_type = "max", -- Set to "max" to sign in with Claude Pro/Max subscription
        -- model = "claude-3-5-sonnet-20241022",
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 4096,
        },
      },
    },
    behaviour = {
      -- Auto-approve only read-only and search operations
      -- All data-modifying operations (create, delete, move, bash, etc.) require manual approval
      auto_approve_tool_permissions = {
        "rag_search", -- Search project files
        "glob", -- Pattern matching for files
        "search_keyword", -- Keyword search
        "read_file_toplevel_symbols", -- Read file structure
        "read_file", -- Read file contents
        "web_search", -- Search the web
        "fetch", -- Fetch remote content
        "git_diff", -- View git differences
      },
    },
  },
}
