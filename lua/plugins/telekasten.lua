return {
  'renerocksai/telekasten.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telekasten').setup({
      home = vim.fn.expand('~/todo'),
      extension = '.md', -- create markdown files
      command_palette_theme = 'get_cursor',
      auto_set_filetype = false,
    })

    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = 'telekasten',
    --   callback = function()
    --     -- treesitter 使用 markdown 解析器
    --     vim.treesitter.language.register('markdown', 'telekasten')
    --   end,
    -- })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>zk', '<CMD>Telekasten panel<CR>')
        vim.keymap.set('n', '<leader>zf', '<CMD>Telekasten find_notes<CR>')
        vim.keymap.set('n', '<leader>zn', '<CMD>Telekasten new_note<CR>')
      end,
    })
  end,
}
