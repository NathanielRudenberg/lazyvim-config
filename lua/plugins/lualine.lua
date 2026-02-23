return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local function get_codecompanion_model()
        local chat = require("codecompanion").last_chat()
        if not chat or not chat.adapter then
          return ""
        end

        local adapter = chat.adapter.formatted_name or chat.adapter.name
        local model = chat.adapter.schema.model.default

        if type(model) == "function" then
          model = model(chat.adapter)
        end

        local short_model = string.match(model, "[^/]+$") or model
        return "🤖 " .. adapter .. ": " .. short_model
      end

      -- Insert the component into the statusline (lualine_x section)
      table.insert(opts.sections.lualine_x, 2, {
        get_codecompanion_model,
        color = function()
          return { fg = Snacks.util.color("Special") }
        end,
      })
    end,
  },
}
