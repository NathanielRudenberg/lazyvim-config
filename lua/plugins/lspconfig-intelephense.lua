return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              environment = {
                includePaths = {
                  "/home/natou/inferable/moodle-core",
                  "/home/natou/inferable/moodle-core/lib",
                },
              },
              files = {
                maxSize = 5000000, -- Increase to 5MB for massive Moodle files
              },
              format = {
                braces = "k&r",
              },
            },
          },
        },
      },
    },
  },
}
