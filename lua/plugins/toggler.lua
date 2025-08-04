return {
  'nguyenvukhang/nvim-toggler',
  config = function()
    require('nvim-toggler').setup({
      inverses = {
        ['true'] = 'false',
        ['on'] = 'off',
        ['enabled'] = 'disabled',
        ['yes'] = 'no',
        ['up'] = 'down',
        ['start'] = 'stop',
        ['open'] = 'close',
        ['allow'] = 'deny',
        ['accept'] = 'reject',
        ['read'] = 'write',
        ['push'] = 'pull',
        ['inbound'] = 'outbound',
        ['public'] = 'private',
        ['online'] = 'offline',
        ['local'] = 'remote',
        ['master'] = 'slave',
        ['primary'] = 'replica',
        ['active'] = 'passive',
        ['show'] = 'hide',
        ['selected'] = 'unselected',
      },
      -- removes the default <leader>i keymap
      remove_default_keybinds = true,
      -- removes the default set of inverses
      remove_default_inverses = true,
      -- auto-selects the longest match when there are multiple matches
      autoselect_longest_match = false,
    })
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set({ 'v', 'n' }, '<leader>;;', require('nvim-toggler').toggle)
      end,
    })
  end,
}
