return {
  "OXY2DEV/markview.nvim",
  lazy = false, -- recommended by the author; markview handles its own lazy loading
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- Optional: for prettier icons
  },
  keys = {
    { "<leader>mv", "<cmd>Markview toggle<cr>", desc = "Toggle Markview" },
    { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Markview split preview" },
  },
}
