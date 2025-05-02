return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  lazy = true,
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    -- 用mini.indentscope配置------------------------
    local useMiniIndentScope = true
    if useMiniIndentScope then
      require('ibl').setup({
        scope = {
          enabled = false,
        }
      })
      return
    else
      -- 不用mini.indentscope配置------------------------
      local highlight = {
        'RainbowGreen',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowViolet',
        'RainbowCyan',
      }
      local hooks = require('ibl.hooks')
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#0bf432' }) -- 设置为注释的绿色
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require('ibl').setup({ scope = { highlight = highlight } })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
  end,
}
