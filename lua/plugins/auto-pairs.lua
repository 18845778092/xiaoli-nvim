return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup({
      disable_filetype = { 'TelescopePrompt', 'vim' },
      map_cr = false, -- 禁用回车键的自动配对
    })
  end,
}
