local color_table = require('core.custom-style').color_table

local M = {}

function M.reset()
  vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#FFD700' })
  vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#DA70D6' })
  vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#179FFF' })
end

return M
