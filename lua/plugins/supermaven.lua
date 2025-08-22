-- ai completion

local is_leetcode_context = require('helper.is-leetcode')

return {
  'supermaven-inc/supermaven-nvim',
  event = 'InsertEnter',
  enabled = not is_leetcode_context(),
  config = function()
    require('supermaven-nvim').setup({
      keymaps = {
        accept_suggestion = '<C-y>',
        clear_suggestion = '<C-x>',
        accept_word = nil,
      },
      ignore_filetypes = {},
      color = {
        suggestion_color = '#ffffff',
        cterm = 244,
      },
      log_level = 'off', -- "off", "warn", "info", "debug", "trace"
      disable_inline_completion = false,
      disable_keymaps = false,
    })
  end,
}
