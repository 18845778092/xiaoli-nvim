return {
  maybe_close_diffview = function()
    if vim.g.diffview_open_flag then
      vim.g.diffview_open_flag = false
      vim.cmd('DiffviewClose')
      return true
    else
      return false
    end
  end,
  maybe_close_gitsigns_blame = function()
    if vim.g.gitsigns_blame_open then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype

        if ft == 'gitsigns-blame' then
          vim.api.nvim_win_close(win, false)
          vim.g.gitsigns_blame_open = false
          return true
        end
      end
    else
      return false
    end
  end,
  maybe_close_quickfix = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
      if buftype == 'quickfix' then
        vim.cmd('cclose')
        return true
      end
    end
    return false
  end,
}
