-- show undo history

return {
  'simnalamburt/vim-mundo',
  build = 'brew install uv && brew install python && python3 -m pip install --break-system-packages --user \'pynvim @ git+https://github.com/neovim/pynvim\'',
  init = function()
    vim.g.mundo_header = 0
    vim.g.mundo_width = 70
    vim.g.mundo_preview_bottom = 0
    vim.g.mundo_right = 1
    vim.g.mundo_verbose_graph = 0

    vim.g.mundo_mappings = {
      ['<cr>'] = 'preview',
      q = 'quit',
    }
  end,
  config = function()
    vim.opt.undofile = true
    vim.opt.undodir = '~/.vim/undo'

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>ut', '<cmd>MundoToggle<cr>')
      end,
      desc = 'Description of the autocmd',
    })
  end,
}
