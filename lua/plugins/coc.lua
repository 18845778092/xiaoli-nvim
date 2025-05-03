return {
  'neoclide/coc.nvim',
  branch = 'master',
  run = 'npm ci',
  config = function()
    vim.g.coc_global_extensions = {
      'coc-tsserver',
      'coc-json',
      'coc-eslint',
      'coc-dot-complete',
      'coc-dash-complete',
      'coc-emmet',
      'coc-html-css-support',
      'coc-highlight', -- coc已内置
      -- 'coc-class-css', --watchman
      'coc-css',
      'coc-lua',
      'coc-markdownlint',
      'coc-markmap',
      'coc-yank',
      'coc-webview',
      'coc-markdown-preview-enhanced',
      'coc-fzf-preview',
      'coc-spell-checker',
      -- 'coc-prettier',
      -- 'coc-rust-analyzer'
    }

    vim.diagnostic.config({
      virtual_text = {
        prefix = '●', -- 设置virtual text的前缀符号
        spacing = 4, -- 设置virtual text与代码的间距
        -- severity_limit = 'Warning', -- 只显示Warning及以上级别的错误
        source = 'if_many', -- 显示错误来源
        format = function(diagnostic)
          return string.format('%s', diagnostic.message)
        end,
      },
      signs = true, -- 在左侧显示错误标记
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
    })

    local signs = { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { --[[ text = icon, ]]
        texthl = hl,
        numhl = hl,
      })
    end

    -- 使用`[g`和`]g`来导航诊断信息
    -- vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
    -- vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })
    local error_color = '#ff6b6b'
    local warn_color = '#ff6b6b'
    local info_colof = '#00bfff'
    local hint_color = '#7fa2b8'

    vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = error_color })
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = warn_color })
    vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = info_colof })
    vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = hint_color })

    vim.api.nvim_set_hl(0, 'DiagnosticFloatingError', { fg = error_color })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn', { fg = warn_color })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo', { fg = info_colof })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint', { fg = hint_color })

    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#72c6b1', bg = '#2a2a2a' }) -- 浮动边框
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#2a2a2a' }) -- 浮动背景色
  end,
}
