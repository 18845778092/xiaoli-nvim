-- mini.nvim collection

return {
  'echasnovski/mini.nvim',
  config = function()
    local color_table = require('core.custom-style').color_table
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
        object_scope = '',
        object_scope_with_border = '',

        goto_top = 'tt',
        goto_bottom = 'tb',
      },

      options = {
        border = 'both',
        indent_at_cursor = true,
        n_lines = 10000,
        try_as_border = false,
      },
      symbol = '┋',
    })
  end,
}
