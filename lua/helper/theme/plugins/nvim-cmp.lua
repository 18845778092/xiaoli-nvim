local color_table = require('core.custom-style').color_table

local M = {}

function M.reset()
  vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#D4D4D4' })
  vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#B180D7' })
  vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#B180D7' })
  vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#B180D7' })
  vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#9CDCFE' })
  vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#9CDCFE' })
  vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#4EC9B0' })
  vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#4EC9B0' })
  vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#4EC9B0' })
  vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#9CDCFE' })
  vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#4EC9B0' })
  vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#569CD6' })
  vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#D7BA7D' })
  vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#D7BA7D' })
  vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#D7BA7D' })
  vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#D7BA7D' })
  vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#D7BA7D' })
  vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = '#4FC1FF' })
  vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#4FC1FF' })
  vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#4EC9B0' })
  vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#e2a144' })
  vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#D4D4D4' })
  vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#4EC9B0' })
end

return M
