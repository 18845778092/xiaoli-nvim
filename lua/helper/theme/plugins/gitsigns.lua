local color_table = require('core.custom-style').color_table

local M = {}

function M.reset()
  vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {
    fg = 'gold',
    italic = true,
  })
end

return M
