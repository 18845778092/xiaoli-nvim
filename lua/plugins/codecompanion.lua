return {
  'olimorris/codecompanion.nvim',
  opts = {},
  build = ':TSInstall markdown markdown_inline',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'github/copilot.vim',
  },
}
