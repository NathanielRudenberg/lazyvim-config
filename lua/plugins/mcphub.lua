return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
    keys = {
      { "<leader>aM", "<cmd>MCPHub<CR>", desc = "MCPHub Dashboard" },
    },
  },
  {
    "yetone/avante.nvim",
    -- enabled = false,
    enabled = function()
      -- Only load this plugin if the LazyVim avante extra is present in lazyvim.json
      local config_path = vim.fn.stdpath("config") .. "/lazyvim.json"
      if vim.fn.filereadable(config_path) == 1 then
        local lazyvim_json = vim.fn.json_decode(vim.fn.readfile(config_path))
        local extras = lazyvim_json.extras or {}
        return vim.tbl_contains(extras, "lazyvim.plugins.extras.ai.avante")
      end
      return false
    end,
    -- system_prompt as function ensures LLM always has latest MCP server state
    -- This is evaluated for every message, even in existing chats
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
    disabled_tools = {
      "list_files", -- Built-in file operations
      "search_files",
      "read_file",
      "create_file",
      "rename_file",
      "delete_file",
      "create_dir",
      "rename_dir",
      "delete_dir",
      "bash", -- Built-in terminal access
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies = {
    --   "franco-ruggeri/mcphub-lualine.nvim",
    --   -- Other dependencies
    -- },
    opts = {
      sections = {
        lualine_x = {
          {
            function()
              -- Check if MCPHub is loaded
              if not vim.g.loaded_mcphub then
                return "󰐻 -"
              end

              local count = vim.g.mcphub_servers_count or 0
              local status = vim.g.mcphub_status or "stopped"
              local executing = vim.g.mcphub_executing

              -- Show "-" when stopped
              if status == "stopped" then
                return "󰐻 -"
              end

              -- Show spinner when executing, starting, or restarting
              if executing or status == "starting" or status == "restarting" then
                local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                local frame = math.floor(vim.loop.now() / 100) % #frames + 1
                return "󰐻 " .. frames[frame]
              end

              return "󰐻 " .. count
            end,
            color = function()
              if not vim.g.loaded_mcphub then
                return { fg = "#6c7086" } -- Gray for not loaded
              end

              local status = vim.g.mcphub_status or "stopped"
              if status == "ready" or status == "restarted" then
                return { fg = "#50fa7b" } -- Green for connected
              elseif status == "starting" or status == "restarting" then
                return { fg = "#ffb86c" } -- Orange for connecting
              else
                return { fg = "#ff5555" } -- Red for error/stopped
              end
            end,
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>a", group = "AI", icon = "🤖" },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true, -- Show tool results directly in chat buffer
            format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            -- MCP Resources
            make_vars = false, -- Convert MCP resources to #variables for prompts
            -- MCP Prompts
            make_slash_commands = true, -- Add MCP prompts as /slash commands
          },
        },
      },
    },
  },
}
