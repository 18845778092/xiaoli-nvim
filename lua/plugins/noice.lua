-- cmdline

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  lazy = true,
  config = function()
    local border = require('core.custom-style').border

    require('noice').setup({
      cmdline = {
        -- 移除命令行边框
        view = 'cmdline_popup',
        opts = {
          border = { style = border },
        },
        format = {
          cmdline = { icon = '>' },
        },
      },
    })
  end,
}
