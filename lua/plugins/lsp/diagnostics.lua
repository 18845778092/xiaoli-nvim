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
      border = 'rounded', -- 浮动窗口的边框样式
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
end

