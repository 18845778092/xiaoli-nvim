-- improve hover experience

return {
  'soulis-1256/eagle.nvim',
  config = function()
    local border = require('core.custom-style').border

    require('eagle').setup({
      show_headers = true,
      order = 1,
      improved_markdown = true,
      mouse_mode = false,
      keyboard_mode = true,
      logging = false,
      close_on_cmd = true,
      show_lsp_info = true,
      scrollbar_offset = 0,
      max_width_factor = 2,
      max_height_factor = 2.5,
      detect_idle_timer = 50,
      window_row = 1,
      window_col = 1,
      border = border,
      title = '',
      title_pos = 'center',
      title_color = '#8AAAE5',
      border_color = '#8AAAE5',
    })
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', 'gh', ':EagleWin<CR>', { noremap = true, silent = true })
      end,
    })
  end,
}
