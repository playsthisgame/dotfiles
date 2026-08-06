return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require("tiny-inline-diagnostic").setup()

    -- Disable the default virtual_text since it's now handled by this plugin
    vim.diagnostic.config({ virtual_text = false })
  end,
}
