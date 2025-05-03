return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    enabled = false,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local visual = '#0A64AC'
        return {
          Normal = { bg = '#1f1f1f' }, -- 主背景色
          Visual = { bg = visual }, -- 可视化选择模式背景色
          TelescopeSelection = { bg = visual }, -- Telescope 选中项背
          PmenuSel = { bg = visual }, -- 弹出菜单选中项背景色
        }
      end,
      theme = 'wave',
      -- background = {
      --   dark = "dragon",
      --   light = "lotus"
      -- },
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd('colorscheme kanagawa-wave')
      local active_line_num = '#a8fcfe'

      vim.api.nvim_set_hl(0, 'CursorLineNr', {
        fg = active_line_num,
        -- bg = "#2a2a36", -- 背景色（深灰色）
        bold = true,
      })
    end,
  },
}
