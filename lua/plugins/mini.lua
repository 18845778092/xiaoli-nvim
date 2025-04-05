return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup({
      custom_textobjects = {
        a = require('mini.ai').gen_spec.argument({ brackets = { '%b()', '%b[]', '%b{}' } }),
      }
    })
  end
}
