return {
  'mg979/vim-visual-multi',
  event = 'VeryLazy',
  init = function()
    vim.g.VM_maps = {
      ['Add Cursor Down'] = '<C-n>',
      ['Add Cursor Up'] = '<C-u>',
      ['Find Under'] = 'gb',
    }
  end,
}
