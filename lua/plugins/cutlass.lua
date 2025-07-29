-- simply delete and not cut

return {
  'gbprod/cutlass.nvim',
  config = function()
    require('cutlass').setup({
      cut_key = 'x', -- key to cut
      override_del = nil,
      exclude = {},
      registers = {
        select = '_',
        delete = '_',
        change = '_',
      },
    })
  end,
}
