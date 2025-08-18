local color_table = require('core.custom-style').color_table

local M = {}

function M.reset()
  vim.api.nvim_set_hl(0, 'SkInactive', {
    bg = color_table.cursor_line_color,
    fg = '#ffffff',
  })
  vim.api.nvim_set_hl(0, 'SkActive', { bg = '#4ce0a9', fg = '#ffffff' })
  vim.api.nvim_set_hl(0, 'ShowKeyBorder', { fg = '#4ce0a9' })
end

return M
