return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    local rainbow_delimiters = require('rainbow-delimiters')

    -- 配置彩虹分隔符
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
      },

      query = {
        [''] = 'rainbow-delimiters',
        -- https://github.com/HiPhish/rainbow-delimiters.nvim/issues/141
        vue = 'rainbow-script',
        html = 'rainbow-script',
      },

      highlight = {
        'RainbowDelimiterYellow',
        'RainbowDelimiterViolet',
        'RainbowDelimiterBlue',
        -- 'RainbowDelimiterGreen',
        -- 'RainbowDelimiterCyan',
        -- 'RainbowDelimiterRed',
      },

      blacklist = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'css',
      },
    }

    -- https://github.com/HiPhish/rainbow-delimiters.nvim/issues/136
    -- vim.g.rainbow_delimiters = {
    --   priority = { vue = 130 },
    -- }

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#FFD700' }) -- 金黄色
        vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#DA70D6' }) -- 兰花紫
        vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#179FFF' }) -- 亮蓝色
        -- vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#00D000' }) -- 亮绿色
        -- vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#00FFFF' }) -- 青色
        -- vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#FF6347' }) -- 番茄红
      end,
    })
  end,
}
