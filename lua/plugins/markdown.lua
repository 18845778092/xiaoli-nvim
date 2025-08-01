return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  config = function()
    local render_modes = { 'n', 'c', 'i', 'v', 'V', 's', 'S' }
    require('render-markdown').setup({
      file_types = { 'markdown', 'codecompanion', 'telekasten' },
      render_modes = render_modes,
      heading = {
        enabled = true,
        sign = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        width = 'full',
        left_margin = 0,
        right_margin = 0,
        min_width = 0,
        border = false,
        border_prefix = false,
      },
      code = {
        enabled = true,
        sign = true,
        style = 'full',
        left_margin = 0,
        right_margin = 0,
        width = 'full',
        border = 'thin',
      },
      bullet = {
        enabled = true,
        icons = { '●', '○', '◆', '◇' },
        right_margin = 0,
        highlight = 'RenderMarkdownBullet',
      },
    })

    -- AI generated...
    local function set_markdown_colors()
      -- 标题颜色 - 背景色与前景色更接近，形成柔和对比
      vim.api.nvim_set_hl(0, 'RenderMarkdownH1', { fg = '#F44336', bold = true }) -- 鲜艳红色
      vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = '#8B3A3A', fg = '#F44336' }) -- 更接近前景色

      vim.api.nvim_set_hl(0, 'RenderMarkdownH2', { fg = '#FF9800', bold = true }) -- 活力橙色
      vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = '#B36B00', fg = '#FF9800' }) -- 更接近前景色

      vim.api.nvim_set_hl(0, 'RenderMarkdownH3', { fg = '#FFEB3B', bold = true }) -- 明亮黄色
      vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = '#B3A52B', fg = '#FFEB3B' }) -- 更接近前景色

      vim.api.nvim_set_hl(0, 'RenderMarkdownH4', { fg = '#4CAF50', bold = true }) -- 清新绿色
      vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = '#3A7A3A', fg = '#4CAF50' }) -- 更接近前景色

      vim.api.nvim_set_hl(0, 'RenderMarkdownH5', { fg = '#00BCD4', bold = true }) -- 青蓝色
      vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = '#008A95', fg = '#00BCD4' }) -- 更接近前景色

      vim.api.nvim_set_hl(0, 'RenderMarkdownH6', { fg = '#9C27B0', bold = true }) -- 紫色
      vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = '#6D1B7A', fg = '#9C27B0' }) -- 更接近前景色

      -- 代码块颜色 - 背景色与前景色更协调
      vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#3A3A4A', fg = '#F8F8F2' })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { bg = '#3A5A3A', fg = '#50FA7B', bold = true })

      -- 列表符号颜色
      vim.api.nvim_set_hl(0, 'RenderMarkdownBullet', { fg = '#FF6E40', bold = true })

      -- 链接颜色
      vim.api.nvim_set_hl(0, 'RenderMarkdownLink', { fg = '#03DAC6', underline = true, bold = true })

      -- 引用块颜色 - 背景色更接近前景色
      vim.api.nvim_set_hl(0, 'RenderMarkdownQuote', { fg = '#BD93F9', italic = true, bg = '#4A3A5A' })

      -- 表格颜色 - 背景色更接近前景色
      vim.api.nvim_set_hl(0, 'RenderMarkdownTableHead', { fg = '#FF5722', bold = true, bg = '#5A2A1A' })
      vim.api.nvim_set_hl(0, 'RenderMarkdownTableRow', { fg = '#E8EAED' })

      -- 分割线颜色
      vim.api.nvim_set_hl(0, 'RenderMarkdownDash', { fg = '#26C6DA', bold = true })

      -- 额外的美化元素
      vim.api.nvim_set_hl(0, 'RenderMarkdownBold', { fg = '#FFC107', bold = true })
      vim.api.nvim_set_hl(0, 'RenderMarkdownItalic', { fg = '#E91E63', italic = true })
      vim.api.nvim_set_hl(0, 'RenderMarkdownStrike', { fg = '#F44336', strikethrough = true })
      vim.api.nvim_set_hl(0, 'RenderMarkdownTodo', { fg = '#FF5722', bold = true })
      vim.api.nvim_set_hl(0, 'RenderMarkdownDone', { fg = '#8BC34A', bold = true })

      -- code
      vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#2D3748', fg = '#E2E8F0' }) -- 深灰背景，浅灰前景
      vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { bg = '#4A5568', fg = '#CBD5E0', bold = false }) -- 内联代码稍亮一些
    end

    vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter', 'ColorScheme' }, {
      pattern = { 'markdown', 'codecompanion', 'telekasten', '*' },
      callback = function()
        -- 延迟执行确保插件完全加载
        vim.schedule(function()
          if vim.bo.filetype == 'markdown' or vim.bo.filetype == 'codecompanion' or vim.bo.filetype == 'telekasten' then
            set_markdown_colors()
          end
        end)
      end,
    })

    -- 立即设置一次颜色
    set_markdown_colors()
  end,
}
