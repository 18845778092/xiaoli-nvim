return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    enabled = false,
    config = function()
      local transparent = true -- set to true if you would like to enable transparency

      local bg = '#011628'
      local bg_dark = '#011423'
      local bg_highlight = '#143652'
      local bg_visual = "#65a14c"
      local bg_search = '#0A64AC'
      local fg = '#CBE0F0'
      local fg_dark = '#B4D0E9'
      local fg_gutter = '#627E97'
      local border = '#547998'
      local comment = "#0bf432"

      require('tokyonight').setup({
        style = 'moon',
        transparent = transparent,
        styles = {
          sidebars = transparent and 'transparent' or 'dark',
          floats = transparent and 'transparent' or 'dark',
        },
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = transparent and colors.none or bg_dark
          colors.bg_float = transparent and colors.none or bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = transparent and colors.none or bg_dark
          colors.bg_statusline = transparent and colors.none or bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
          colors.comment = comment
        end,
      })

      vim.cmd('colorscheme tokyonight')

      vim.api.nvim_set_hl(0, 'CursorWord', { bg = '#454b59', underline = false })
      vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#373D4B' })
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    enabled = false,
    priority = 1000,
    config = function()
      local github_theme = require('github-theme')

      github_theme.setup({})

      vim.cmd('colorscheme github_light_default')

      vim.api.nvim_set_hl(0, 'CursorWord', { bg = '#b4dbfd', underline = false })
      vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#f5f6f8' })
    end,
  },
}
