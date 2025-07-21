-- lazygit

return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  build = 'brew install lazygit',
  event = 'BufWinEnter',
  dependencies = {
    'sindrets/diffview.nvim',
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap

    vim.g.lazygit_use_custom_config_file_path = 1
    vim.g.lazygit_config_file_path = os.getenv('HOME') .. '/.config/lazygit/config.yml' -- 使用动态获取的主目录路径 -- custom config file path

    keymap.set('n', '<leader>gg', '<CMD>LazyGit<CR>', { desc = 'Open LazyGit' })
  end,
}
