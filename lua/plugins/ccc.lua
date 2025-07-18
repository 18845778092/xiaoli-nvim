-- color highlight and color picker

return {
  'uga-rosa/ccc.nvim',
  config = function()
    require('ccc').setup({
      highlighter = { auto_enable = true },
      filetypes = { 'css', 'scss', 'vue' },
    })
  end,
}
