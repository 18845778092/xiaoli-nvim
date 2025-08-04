-- surround tip

return {
  'roobert/surround-ui.nvim',
  dependencies = {
    'kylechui/nvim-surround',
    'folke/which-key.nvim',
  },
  config = function()
    require('surround-ui').setup({
      root_key = 'S', -- leader S
    })
  end,
}
