-- ai completion

local is_leetcode_context = require('helper.is-leetcode')

return {
  'Exafunction/windsurf.vim',
  event = 'BufEnter',
  enabled = false,
  config = function()
    -- C-y接受ai
    vim.keymap.set('i', '<C-y>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true })
    -- C-x清除ai预览
    vim.keymap.set('i', '<C-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true })
    vim.g.codeium_no_map_tab = 1
  end,
}
