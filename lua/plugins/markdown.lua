return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  config = function()
    local render_modes = { 'n', 'c', 'i', 'v', 'V', 's', 'S' }
    require('render-markdown').setup({
      file_types = { 'markdown', 'codecompanion', 'telekasten' },
      render_modes = render_modes,
      heading = {
        width = 'block',
        sign = false,
        left_pad = 1,
        right_pad = 0,
        position = 'right',
        icons = {
          '',
          '',
          '',
          '',
          '',
          '',
        },
      },
      code = {
        sign = false,
        border = 'thin',
        position = 'right',
        width = 'block',
        above = '▁',
        below = '▔',
        language_left = '█',
        language_right = '█',
        language_border = '▁',
        left_pad = 1,
        right_pad = 1,
      },
      checkbox = {
        enable = true,
        position = 'inline',
      },
    })

    vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter', 'ColorScheme' }, {
      pattern = { 'markdown', 'codecompanion', 'telekasten' },
      callback = function()
        -- 延迟执行确保插件完全加载
        vim.schedule(function()
          if vim.bo.filetype == 'markdown' or vim.bo.filetype == 'codecompanion' or vim.bo.filetype == 'telekasten' then
            -- require('theme.plugins.render-markdown').reset()
          end
        end)
      end,
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        -- require('theme.plugins.render-markdown').reset()
      end,
    })
  end,
}
