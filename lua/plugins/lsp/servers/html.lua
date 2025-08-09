return function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.config('html', {
    capabilities = capabilities,
  })
  vim.lsp.enable('html')
end
