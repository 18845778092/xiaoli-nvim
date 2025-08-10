local color_table = require('core.custom-style').color_table

local M = {}

function M.reset()
  vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = color_table.active_line_num_color }) -- mini.indentscope指示线颜色
end

return M
