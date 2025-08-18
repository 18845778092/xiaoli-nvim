local color_table = require('core.custom-style').color_table

local M = {}

function M.reset()
  vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = color_table.light_green })
end

return M
