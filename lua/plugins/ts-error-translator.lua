-- Turning messy and confusing TypeScript errors into plain English.

return {
  'dmmulroy/ts-error-translator.nvim',
  config = function()
    require('ts-error-translator').setup({
      auto_override_publish_diagnostics = true,
    })
  end,
}
