-- custom vscode like rainbow delimiters

return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    local rainbow_delimiters = require('rainbow-delimiters')

    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'], -- static
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
      },
    }

    -- https://github.com/HiPhish/rainbow-delimiters.nvim/issues/136
    -- vim.g.rainbow_delimiters = {
    --   priority = { vue = 130 },
    -- }

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#FFD700' })
        vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#DA70D6' })
        vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#179FFF' })
        -- vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#00D000' })
        -- vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#00FFFF' })
        -- vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#FF6347' })
      end,
    })
  end,
}
