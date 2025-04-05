return {
  'barrett-ruth/live-server.nvim',
  build = 'npm install -g live-server',
  config = function()
    require('live-server').setup({
      'barrett-ruth/live-server.nvim',
      build = 'pnpm add -g live-server',
      cmd = { 'LiveServerStart', 'LiveServerStop' },
      config = true,
      -- args = { '--port=5000' },
      -- html_files = { "*.html", "*.htm" },
      -- js_files = { "*.js" },
      -- css_files = { "*.css" },
      -- -- 添加 jobstart 配置
      -- jobstart = function(cmd)
      --   return vim.fn.jobstart(cmd, {
      --     on_stdout = function(_, data)
      --       print('LiveServer: ' .. table.concat(data, '\n'))
      --     end,
      --     on_stderr = function(_, data)
      --       print('LiveServer Error: ' .. table.concat(data, '\n'))
      --     end,
      --   })
      -- end,
    })
  end,
}
