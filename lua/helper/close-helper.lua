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
}
