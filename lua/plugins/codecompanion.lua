return {
  'olimorris/codecompanion.nvim',
  opts = {},
  build = ':TSInstall markdown markdown_inline',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'github/copilot.vim',
    'j-hui/fidget.nvim',
    'franco-ruggeri/codecompanion-spinner.nvim',
  },
  init = function()
    require('helper.codecompanion-fidget-spinner'):init()
  end,
  config = function()
    require('codecompanion').setup({
      extensions = {
        spinner = {},
      },
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>pp', '<CMD>CodeCompanionChat Toggle<CR>')
      end,
    })
  end,
}
