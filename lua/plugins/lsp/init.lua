-- Neovim built-in LSP

return {
  'neovim/nvim-lspconfig',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'nvimdev/lspsaga.nvim',
  },
  config = function()
    require('plugins.lsp.mason')()
    require('plugins.lsp.lspsaga')()
    require('plugins.lsp.servers')()
    require('plugins.lsp.diagnostics')()

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
  end,
}
