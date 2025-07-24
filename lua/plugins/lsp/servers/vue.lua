return function()
  local vue_language_server_path = vim.fn.expand('$MASON/packages')
    .. '/vue-language-server'
    .. '/node_modules/@vue/language-server'

  local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
  }

  local vtsls_config = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
      typescript = {
        inlayHints = {
          parameterNames = { enabled = 'all', suppressWhenArgumentMatchesName = false },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      javascript = {
        inlayHints = {
          parameterNames = { enabled = 'all', suppressWhenArgumentMatchesName = false },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
    },
    filetypes = {
      'typescript',
      'javascript',
      'javascriptreact',
      'typescriptreact',
      'vue',
    },
  }

  local vue_ls_config = {}

  vim.lsp.config('vtsls', vtsls_config) -- vue 文件 ts部分支持
  vim.lsp.config('vue_ls', vue_ls_config) -- vue文件 html css支持

  vim.lsp.enable({
    'vtsls',
    'vue_ls',
  })
  vim.lsp.inlay_hint.enable()
end
