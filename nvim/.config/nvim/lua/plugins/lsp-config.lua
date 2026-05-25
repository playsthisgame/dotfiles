return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        jdtls = {
          settings = {
            java = {
              format = {
                enabled = true,
                settings = {
                  url = vim.fn.stdpath("config") .. "/eclipse-java-style.xml",
                },
              },
            },
          },
        },
      },
    },
  },
}
