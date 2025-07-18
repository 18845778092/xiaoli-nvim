return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  lazy = true,
  config = function()
    require('noice').setup({
      cmdline = {
        -- 移除命令行边框
        view = 'cmdline_popup',
        opts = {
          border = { style = 'single' },
        },
        format = {
          cmdline = { icon = '>' },
        },
      },
    })
  end,
}
