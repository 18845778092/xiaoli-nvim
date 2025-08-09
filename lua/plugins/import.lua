return {
  'piersolenski/import.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('import').setup({
      picker = 'telescope',
      insert_at_top = false,
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>fi', function()
          require('import').pick()
        end, { desc = 'Import' })
      end,
    })
  end,
}
