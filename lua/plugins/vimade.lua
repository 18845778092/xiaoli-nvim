-- maintain focus on the active part of the screen

return {
  'tadaa/vimade',
  config = function()
    require('vimade').setup({
      recipe = { 'default', { animate = true } },
      ncmode = 'windows',
      fadelevel = 0.4,
    })
  end,
}
