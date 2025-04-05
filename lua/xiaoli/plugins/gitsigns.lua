return {
  'lewis6991/gitsigns.nvim',
  event = 'BufRead',
  config = function()
    require('gitsigns').setup {
      current_line_blame = true,
      current_line_blame_opts = { delay = 0 },
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    }
  end
}
