return {
  {
    "akinsho/toggleterm.nvim",
    -- config = true,
    cmd = "ToggleTerm",
    keys = { { "<F4>", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" } },
    opts = {
      open_mapping = [[<F4>]],
      direction = "horizontal",
      size = function(term)
        if term.direction == "horizontal" then
          return 20 -- Set default height for horizontal splits
        elseif term.direction == "vertical" then
          return 80 -- Set default width for vertical splits
        end
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
