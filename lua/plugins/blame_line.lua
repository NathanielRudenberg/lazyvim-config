return {
  "braxtons12/blame_line.nvim",
  config = function()
    require("blame_line").setup({
      -- Whether to show the virtual text blame line when the cursor is moved.
      show_on_cursor_move = true,
      -- Whether to show the virtual text blame line when the buffer is opened.
      show_on_buffer_enter = true,
      -- Whether to show the virtual text blame line when the buffer is saved.
      show_on_save = true,
      -- Whether to show the virtual text blame line when the buffer is written.
      show_on_write = true,
      -- Whether to show the blame line in insert mode.
      show_in_insert_mode = false,
      -- Whether to show the blame line in visual mode.
      show_in_visual_mode = true,
    })
  end,
}
