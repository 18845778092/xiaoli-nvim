-- Neovim built-in LSP

return {
  'neovim/nvim-lspconfig',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'nvimdev/lspsaga.nvim',
  },
  build = {
    'npm i -g vscode-langservers-extracted',
    'npm i -g eslint',
  },
  config = function()
    require('plugins.lsp.mason')()
    require('plugins.lsp.lspsaga')()
    require('plugins.lsp.servers')()
    require('plugins.lsp.diagnostics')()
  end,
}
