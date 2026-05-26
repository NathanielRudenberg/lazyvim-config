return {
  {
    "akinsho/toggleterm.nvim",
    -- config = true,
    cmd = "ToggleTerm",
    keys = {
      {
        "<F4>",
        function()
          local count = vim.v.count
          -- When the current window is a floating picker (e.g. snacks explorer),
          -- ToggleTerm's is_split() calls ui.is_float(nil) which falls back to
          -- win_gettype(0) (current window). A floating window returns "popup",
          -- causing is_split() to return false → "Invalid terminal direction" error.
          -- Fix: move focus to any regular (non-floating) background window first.
          if vim.fn.win_gettype() == "popup" then
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
              if vim.fn.win_gettype(win) == "" then
                vim.api.nvim_set_current_win(win)
                break
              end
            end
          end
          vim.cmd(count .. "ToggleTerm direction=horizontal")
        end,
        desc = "Toggle terminal",
        mode = { "n", "t" },
      },
    },
    opts = {
      -- direction = "horizontal",
      size = function(term)
        if term and term.direction then
          if term.direction == "horizontal" then
            return 20 -- Set default height for horizontal splits
          elseif term.direction == "vertical" then
            return 80 -- Set default width for vertical splits
          end
        end
        return 20 -- Fallback to a default size
      end,
      shade_filetypes = {},
      shade_terminals = true,
      hide_numbers = false,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
    },
  },
}
