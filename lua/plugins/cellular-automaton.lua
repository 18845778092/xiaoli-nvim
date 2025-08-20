-- A useless plugin

return {
  'Eandrju/cellular-automaton.nvim',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', '<leader>mr', '<cmd>CellularAutomaton make_it_rain<CR>')
    vim.keymap.set('n', '<leader>mg', '<cmd>CellularAutomaton game_of_life<CR>')
  end,
}
