return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require('bufferline').setup({
      options = {
        -- 使用 nvim 内置lsp
        diagnostics = 'nvim_lsp',
        -- 左侧让出 nvim-tree 的位置
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    })
    -- 添加跳转快捷键
    vim.keymap.set('n', '<leader>pp', '<Cmd>BufferLineCyclePrev<CR>', { desc = '上一个buffer' })
    -- vim.keymap.set('n', '<leader>bn', '<Cmd>BufferLineCycleNext<CR>', { desc = '下一个buffer' })
  end,
}
