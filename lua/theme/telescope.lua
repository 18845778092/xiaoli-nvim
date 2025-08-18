local M = {}

-- gruvbox-material 主题色彩
M.set_hl_with_gruvbox = function()
  local colors = {
    bg0 = '#1d2021',
    bg1 = '#282828',
    fg = '#d4be98',

    red = '#ea6962',
    green = '#a9b665',
    yellow = '#d8a657',
    blue = '#7daea3',
    purple = '#d3869b',
    aqua = '#89b482',
    orange = '#e78a4e',

    grey0 = '#7c6f64',
    grey1 = '#928374',
    grey2 = '#a89984',
  }

  -- 输入框
  vim.api.nvim_set_hl(0, 'TelescopePromptTitle', {
    fg = colors.bg0,
    bg = colors.yellow,
    bold = true,
  })
  -- 搜索计数器
  vim.api.nvim_set_hl(0, 'TelescopePromptCounter', {
    link = '@keyword.function.lua',
  })
  -- 搜索框边框
  vim.api.nvim_set_hl(0, 'TelescopePromptBorder', {
    fg = colors.yellow,
    bg = 'NONE',
    bold = true,
  })

  -- 结果列表边框
  vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', {
    fg = colors.green,
    bg = 'NONE',
  })
  -- 结果
  vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', {
    fg = colors.bg0,
    bg = colors.green,
    bold = true,
  })
  -- 匹配文本
  vim.api.nvim_set_hl(0, 'TelescopeMatching', {
    link = 'Search',
  })

  -- 预览窗口边框  使用蓝色表示预览区域
  vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', {
    fg = colors.blue,
    bg = 'NONE',
  })
  -- 预览
  vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', {
    fg = colors.bg0,
    bg = colors.blue,
    bold = true,
  })
end

return M
