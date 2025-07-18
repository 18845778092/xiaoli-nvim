return function()
  vim.lsp.config('eslint', {
    settings = {
      format = false, -- 使用biome修复错误
    },
  })
  vim.lsp.enable('eslint')
end
