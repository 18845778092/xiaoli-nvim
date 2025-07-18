-- terminal

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      -- 基础配置
      size = 20,
      open_mapping = [[<c-\>]], -- 默认快捷键 Ctrl+\
      direction = 'horizontal', -- 浮动窗口
      float_opts = {
        border = 'float', -- 圆角边框
      },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      -- 添加自定义快捷键 <leader>tt 打开/关闭终端
      vim.keymap.set({ 'n', 't' }, '<C-t>', '<CMD>ToggleTerm<CR>', {
        noremap = true,
        silent = true,
        desc = 'Toggle terminal',
      })
    end,
  },
}
