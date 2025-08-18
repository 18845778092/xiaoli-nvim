local M = {}

-- 动态获取背景色的函数
local function get_adaptive_bg()
  -- 检查是否在浮动窗口中
  local win_config = vim.api.nvim_win_get_config(0)
  if win_config.relative ~= '' then
    -- 在浮动窗口中，尝试获取 NormalFloat 背景
    local float_hl = vim.api.nvim_get_hl(0, { name = 'NormalFloat' })
    if float_hl.bg then
      return string.format('#%06x', float_hl.bg)
    end
  end

  -- 普通窗口，获取 Normal 背景
  local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
  if normal_hl.bg then
    return string.format('#%06x', normal_hl.bg)
  end

  -- 默认背景色
  return '#1e1e1e'
end

function M.reset()
  local current_bg = get_adaptive_bg()
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = current_bg }) -- 影响 global-note 渲染markdown header 后空白部分颜色

  -- H1 - 天蓝色
  vim.api.nvim_set_hl(0, 'RenderMarkdownH1', { bg = current_bg, fg = current_bg, bold = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = '#3B82F6', fg = 'NONE' })

  -- H2 - 橙色
  vim.api.nvim_set_hl(0, 'RenderMarkdownH2', { bg = current_bg, fg = current_bg, bold = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = '#F97316', fg = 'NONE' })

  -- H3 - 绿色
  vim.api.nvim_set_hl(0, 'RenderMarkdownH3', { bg = current_bg, fg = current_bg, bold = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = '#22C55E', fg = 'NONE' })

  -- H4 - 紫色
  vim.api.nvim_set_hl(0, 'RenderMarkdownH4', { bg = current_bg, fg = current_bg, bold = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = '#A855F7', fg = 'NONE' })

  -- H5 - 粉红色
  vim.api.nvim_set_hl(0, 'RenderMarkdownH5', { bg = current_bg, fg = current_bg, bold = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = '#EC4899', fg = 'NONE' })

  -- H6 - 黄色
  vim.api.nvim_set_hl(0, 'RenderMarkdownH6', { bg = current_bg, fg = current_bg, bold = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = '#EAB308', fg = 'NONE' })

  -- 分割线颜色
  vim.api.nvim_set_hl(0, 'RenderMarkdownDash', { fg = '#26C6DA', bold = true })

  -- 额外的美化元素
  vim.api.nvim_set_hl(0, 'RenderMarkdownBold', { fg = '#FFC107', bold = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownItalic', { fg = '#E91E63', italic = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownStrike', { fg = '#F44336', strikethrough = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownTodo', { fg = '#FF5722', bold = true })
  vim.api.nvim_set_hl(0, 'RenderMarkdownDone', { fg = '#8BC34A', bold = true })

  -- 标题文本颜色
  vim.api.nvim_set_hl(0, '@text.title.markdown', { fg = '#ffffff', bold = true })

  -- 代码块颜色
  vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#2D3748' })
  vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { bg = '#4A5568', bold = false })
end

return M
