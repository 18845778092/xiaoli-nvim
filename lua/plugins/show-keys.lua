return {
  'nvzone/showkeys',
  event = 'VeryLazy',
  config = function()
    local showkeys = require('showkeys')
    showkeys.setup({
      winopts = {
        focusable = false,
        relative = 'editor',
        style = 'minimal',
        border = 'single',
        height = 1,
        row = 1,
        col = 0,
        zindex = 100,
      },
      winhl = 'FloatBorder:ShowKeyBorder,Normal:Normal',
      timeout = 3, -- in secs
      maxkeys = 5,
      show_count = true,
      excluded_modes = {}, -- example: {"i"}

      -- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
      position = 'top-right',

      keyformat = {
        ['<BS>'] = '󰁮 ',
        ['<CR>'] = '󰘌',
        ['<Space>'] = '󱁐',
        ['<Up>'] = '󰁝',
        ['<Down>'] = '󰁅',
        ['<Left>'] = '󰁍',
        ['<Right>'] = '󰁔',
        ['<PageUp>'] = 'Page 󰁝',
        ['<PageDown>'] = 'Page 󰁅',
        ['<M>'] = 'Alt',
        ['<C>'] = 'Ctrl',
      },
    })
    local color_table = require('core.custom-style').color_table

    vim.api.nvim_set_hl(0, 'SkInactive', {
      bg = color_table.cursor_line_color,
      fg = '#ffffff',
    })
    vim.api.nvim_set_hl(0, 'SkActive', { bg = '#4ce0a9', fg = '#ffffff' })
    vim.api.nvim_set_hl(0, 'ShowKeyBorder', { fg = '#4ce0a9' })
    showkeys.toggle() -- 默认打开
  end,
}
