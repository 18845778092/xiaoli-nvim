-- A jump plugin to replace flash.nvim

return {
  'ggandor/leap.nvim',
  enabled = true,
  dependencies = { 'tpope/vim-repeat' },
  config = function()
    local leap = require('leap')

    leap.setup({
      case_sensitive = true,
      equivalence_classes = { ' \t\r\n' },
      safe_labels = 'sfnut/SFNLHMUGTZ?',
      labels = 'sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?',
      keys = {
        next_target = '<enter>',
        prev_target = '<tab>',
        next_group = '<space>',
        prev_group = '<tab>',
      },
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set({ 'n', 'x', 'o' }, 'f', function()
          leap.leap({
            backward = false,
          })
        end, { desc = 'Leap forward to' })

        vim.keymap.set({ 'n', 'x', 'o' }, 'F', function()
          leap.leap({ backward = true })
        end, { desc = 'Leap backward to' })
      end,
      desc = 'Description of the autocmd',
    })
  end,
}
