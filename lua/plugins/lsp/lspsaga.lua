-- improves the Neovim built-in LSP experience

return function()
  local border = require('core.custom-style').border
  require('lspsaga').setup({
    ui = {
      border = border, -- 非圆角边框
    },
    diagnostic = {
      keys = {
        quit = { 'q', '<ESC>' },
      },
    },
    code_action = {
      show_server_name = true,
    },
  })

  vim.keymap.set('n', 'gh', '<cmd>Lspsaga hover_doc<CR>')
  vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>')
  vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>')
  vim.keymap.set('n', '<leader>le', '<cmd>Lspsaga show_buf_diagnostics<CR>')
end
