return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",  -- use clippy instead of check
            },
            cargo = {
              allFeatures = true,
            },
            inlayHints = {
              lifetimeElisionHints = {
                enable = "always",
              },
            },
          },
        },
      },
    },
  },
}
