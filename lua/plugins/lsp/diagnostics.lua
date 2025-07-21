-- diagnostic display setting

return function()
  vim.diagnostic.config({
    virtual_text = {
      prefix = '●', -- virtual text的前缀符号
      spacing = 4, -- virtual text与代码的间距
      source = 'if_many', -- 显示错误来源
      format = function(diagnostic)
        return string.format('%s', diagnostic.message)
      end,
    },
    underline = true, -- 在错误代码下方显示下划线
    update_in_insert = false, -- 在插入模式下不更新diagnostic
    float = {
      border = 'double', -- 浮动窗口的边框样式
      focusable = false, -- 浮动窗口不可聚焦
      source = 'if_many', -- 显示错误来源
      format = function(diagnostic)
        return string.format('%s', diagnostic.message)
      end,
    },
    severity_sort = true, -- 按严重程度排序诊断信息
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
      texthl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
        [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
        [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
        [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
        [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
        [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
        [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
      },
    },
  })

  local error_color = '#ff6b6b'
  local warn_color = '#ffff44'
  local info_colof = '#44ffff'
  local hint_color = '#7fa2b8'
  vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = error_color })
  vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = warn_color })
  vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = info_colof })
  vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = hint_color })

  vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = error_color, bg = 'none' })
  vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = warn_color, bg = 'none' })
  vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = info_colof, bg = 'none' })
  vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = hint_color, bg = 'none' })

  vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#72c6b1', bg = '#2a2a2a' }) -- 浮动边框
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#2a2a2a' }) -- 浮动背景色
end
