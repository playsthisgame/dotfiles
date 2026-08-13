return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = opts.picker or {}
    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.explorer = opts.picker.sources.explorer or {}
    
    -- Set hidden and ignored to true by default
    opts.picker.sources.explorer.hidden = true
    opts.picker.sources.explorer.ignored = true

    -- Delete the current scratch buffer and its file on disk
    opts.scratch = opts.scratch or {}
    opts.scratch.win = opts.scratch.win or {}
    opts.scratch.win.keys = opts.scratch.win.keys or {}
    opts.scratch.win.keys.delete = {
      "<C-x>",
      function(self)
        local buf, file = self.buf, vim.api.nvim_buf_get_name(self.buf)
        vim.api.nvim_win_call(self.win, function()
          vim.cmd([[close]])
        end)
        -- wipe the buffer first: autowrite rewrites the file on BufHidden,
        -- and a stale loaded buffer would resurrect it on the next open
        vim.api.nvim_buf_delete(buf, { force = true })
        vim.fn.delete(file)
        vim.notify("Deleted scratch: " .. vim.fn.fnamemodify(file, ":t"))
      end,
      desc = "Delete scratch",
      mode = { "n", "x" },
    }

    return opts
  end,
}
