return {
  'windwp/nvim-ts-autotag',
  ft = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue' },
  config = function()
    require('nvim-ts-autotag').setup({
      filetypes = {
        'html',
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'vue',
      },
      skip_tags = {
        'area',
        'base',
        'br',
        'col',
        'command',
        'embed',
        'hr',
        'img',
        'input',
        'keygen',
        'link',
        'meta',
        'param',
        'source',
        'track',
        'wbr',
      },
    })
  end,
}
