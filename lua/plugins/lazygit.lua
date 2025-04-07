return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  event = 'BufWinEnter',
  dependencies = {
    'sindrets/diffview.nvim',
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap

    vim.g.lazygit_use_custom_config_file_path = 1
    vim.g.lazygit_config_file_path = '/Users/chezemin/.config/lazygit/config.yml' -- custom config file path

    keymap.set('n', '<leader>g', '<CMD>LazyGit<CR>', { desc = 'Open LazyGit' })
  end,
}
