return function()
  local color_table = require('core.custom-style').color_table
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
    on_attach = function(client, bufnr)
      if vim.bo[bufnr].filetype == 'vue' then
        client.server_capabilities.semanticTokensProvider.full = false
      end
    end,
  }

  local vue_ls_config = {
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider.full = true
    end,
  }

  vim.lsp.config('vtsls', vtsls_config) -- vue 文件 ts部分支持
  vim.lsp.config('vue_ls', vue_ls_config) -- vue文件 html css支持

  vim.lsp.enable({
    'vtsls',
    'vue_ls',
  })

  -- 注册LSP附加回调
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      -- 设置高亮组 @lsp.type.component 链接到 @type 默认组件绿
      -- vim.api.nvim_command('highlight link @lsp.type.component @type')
      vim.api.nvim_set_hl(0, '@lsp.type.component', { -- 自定义组件颜色
        fg = color_table.vue_component_color,
        bold = true,
      })
    end,
  })

  vim.lsp.inlay_hint.enable()
end
