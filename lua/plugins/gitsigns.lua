-- gitsigns

return {
  'lewis6991/gitsigns.nvim',
  event = 'BufRead',
  config = function()
    vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', {
      fg = 'gold', -- 使用和注释相同的颜色
      italic = true, -- 保持斜体样式（可选）
    })
    require('gitsigns').setup({
      current_line_blame = true,
      current_line_blame_opts = { delay = 0 },
      current_line_blame_formatter = 'commit: <abbrev_sha>, <author>, <author_time:%R> - <summary>',
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- 当前行提交记录完整信息
        map('n', '<leader>gb', function()
          gitsigns.blame_line({ full = true })
        end)

        -- 当前文件提交完整记录
        map('n', '<leader>gB', function()
          gitsigns.blame()
        end)
      end,
    })
  end,
}
