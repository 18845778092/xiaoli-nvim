return {
  'lewis6991/gitsigns.nvim',
  event = 'BufRead',
  config = function()
    vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {
      fg = 'gold',  -- 使用和注释相同的颜色
      italic = true -- 保持斜体样式（可选）
    })
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
