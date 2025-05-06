return {
  'YaQia/darkplus.nvim',
  enabled = true,
  config = function()
    vim.cmd([[colorscheme darkplus]])

    local active_line_num = '#a8fcfe'

    vim.api.nvim_set_hl(0, 'CursorLineNr', {
      fg = active_line_num,
      -- bg = "#2a2a36", -- 背景色（深灰色）
      bold = true,
    })
    vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#e53f73' }) -- mini.indentscope指示线颜色
  end,
}
