return {
  "yetone/avante.nvim",
  opts = {
    behaviour = {
      -- Auto-approve only read-only and search operations
      -- All data-modifying operations (create, delete, move, bash, etc.) require manual approval
      auto_approve_tool_permissions = {
        "rag_search",                   -- Search project files
        "glob",                         -- Pattern matching for files
        "search_keyword",               -- Keyword search
        "read_file_toplevel_symbols",   -- Read file structure
        "read_file",                    -- Read file contents
        "web_search",                   -- Search the web
        "fetch",                        -- Fetch remote content
        "git_diff",                     -- View git differences
      },
    },
  },
}

