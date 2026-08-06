-- vim-tmux-navigator is kept loaded (with its own mappings disabled) so its
-- TmuxNavigate* commands remain available as a fallback when running inside tmux.
-- The actual <C-h/j/k/l> maps live in lua/config/keymaps.lua so they load on
-- VeryLazy and win over LazyVim's default window-navigation maps. Those maps are
-- herdr-aware (vim-herdr-navigation): they cross into neighbouring herdr panes
-- at a Neovim split edge.
return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
