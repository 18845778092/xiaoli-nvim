return function()
  require('lspsaga').setup({
    ui = {
      border = 'single', -- 设置为非圆角边框
    },
    diagnostic = {
      keys = {
        quit = { 'q', '<ESC>' },
      },
    },
  })

  vim.keymap.set('n', 'gh', '<cmd>Lspsaga hover_doc<CR>')
  vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>')
  vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>')
  vim.keymap.set('n', '<leader>le', '<cmd>Lspsaga show_buf_diagnostics<CR>')
end

