return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      --require("nvim-tree").setup({})

      local api = require("nvim-tree.api")

      local function git_add()
        local node = api.tree.get_node_under_cursor()
        local gs = node.git_status.file

        -- If the current node is a directory get children status
        if gs == nil then
          gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
            or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
        end

        -- If the file is untracked, unstaged or partially staged, we stage it
        if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
          vim.cmd("silent !git add " .. node.absolute_path)

        -- If the file is staged, we unstage
        elseif gs == "M " or gs == "A " then
          vim.cmd("silent !git restore --staged " .. node.absolute_path)
        end

        api.tree.reload()
      end

      local function my_on_attach(bufnr)
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        --vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
        --vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "ga", git_add, opts("Git Add"))
        vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>")
      end

      -- pass to setup along with your other options
      require("nvim-tree").setup({
        ---
        on_attach = my_on_attach,
        ---
      })
    end,
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    --enabled = false,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },
}
