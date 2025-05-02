-- 结合coc使用的配置
return {
  'hrsh7th/nvim-cmp',
  event = { 'BufReadPre', 'BufNewFile', 'VimEnter' },
  enabled = true,
  dependencies = {
    'hrsh7th/cmp-path',    -- source for file system paths
    'hrsh7th/cmp-cmdline', -- cmdline auto-completion
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      performance = {
        max_view_entries = 30,
      },
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },
      }),
    })
  end,
}
