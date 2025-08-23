local M = {}

function M.open_cwd_project(cwd)
  vim.cmd('edit ' .. cwd)
  local terminal_helper = require('helper.toggleterm')
  terminal_helper.init_and_warmup()
end

return M
