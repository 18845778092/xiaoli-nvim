return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup({
      custom_textobjects = {
        -- ia aa 参数处理
        a = require('mini.ai').gen_spec.argument({ brackets = { '%b()', '%b[]', '%b{}' } }),
      },
    })
    local indent_scope_instance = require('mini.indentscope')
    indent_scope_instance.setup({
      draw = {
        delay = 50,
        predicate = function(scope)
          return not scope.body.is_incomplete
        end,
        priority = 2,
      },
      mappings = {
        object_scope = 'ii',
        object_scope_with_border = 'ai',
        goto_top = 'tt',
        goto_bottom = 'tb',
      },

      options = {
        border = 'both',
        indent_at_cursor = true,
        n_lines = 10000,
        try_as_border = false,
      },
      symbol = '▎',
    })
  end,
}
