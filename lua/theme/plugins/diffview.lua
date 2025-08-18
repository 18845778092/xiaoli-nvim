local M = {}

function M.reset()
  local diff_green = '#4e5c34'
  vim.api.nvim_set_hl(0, 'DiffDelete', {
    bg = 'NONE',
    fg = '#474849',
  })
  vim.api.nvim_set_hl(0, 'DiffAdd', {
    bg = diff_green,
  })
  vim.api.nvim_set_hl(0, 'DiffText', {
    fg = 'NONE',
    bg = diff_green,
  })
end

return M
