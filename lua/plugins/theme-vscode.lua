-- vscode like theme

return {
  'YaQia/darkplus.nvim',
  enabled = true,
  config = function()
    vim.cmd([[colorscheme darkplus]])
    local color_table = require('core.custom-style').color_table

    vim.api.nvim_set_hl(0, 'CursorLineNr', {
      fg = color_table.active_line_num_color,
      bold = true,
    })
  end,
}
