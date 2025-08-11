return {
  'LudoPinelli/comment-box.nvim',
  config = function()
    require('comment-box').setup({})
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        -- :CBcatalog 查看样式
        vim.keymap.set({ 'n', 'v' }, '<leader>cb', '<CMD>CBccbox17<cr>', { desc = 'Comment - box center' })
        vim.keymap.set({ 'n', 'v' }, '<leader>ci', '<CMD>CBccline17<cr>', { desc = 'Comment - line center' })
      end,
    })
  end,
}
