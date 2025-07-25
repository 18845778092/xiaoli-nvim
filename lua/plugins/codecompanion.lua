return {
  'olimorris/codecompanion.nvim',
  opts = {},
  build = ':TSInstall markdown markdown_inline',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'github/copilot.vim',
  },
  config = function()
    require('codecompanion').setup()

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>pp', '<CMD>CodeCompanionChat Toggle<CR>')
      end,
    })
  end,
}
