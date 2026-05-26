return {
  {
    "coder/claudecode.nvim",
    enabled = function()
      local config_path = vim.fn.stdpath("config") .. "/lazyvim.json"
      if vim.fn.filereadable(config_path) == 1 then
        local lazyvim_json = vim.fn.json_decode(vim.fn.readfile(config_path))
        local extras = lazyvim_json.extras or {}
        return vim.tbl_contains(extras, "lazyvim.plugins.extras.ai.claudecode")
      end
      return false
    end,
    opts = {
      diff_opts = {
        open_in_new_tab = true,
      },
    },
  },
}
