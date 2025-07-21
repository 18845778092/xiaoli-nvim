-- lsp management

return function()
  require('mason-lspconfig').setup({
    automatic_enable = false,
    ensure_installed = {
      'lua_ls',
      'eslint',
      'vtsls', -- vue script部分和ts文件的ts解析
      'vue_ls', -- vue模板和css解析
    },
  })
  require('mason').setup({
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  })
end
