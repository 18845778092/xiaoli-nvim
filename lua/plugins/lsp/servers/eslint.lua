return function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  vim.lsp.config('eslint', {
    capabilities = capabilities,
    settings = {
      format = false, -- 使用biome修复错误
    },
  })
  vim.lsp.enable('eslint')
end
