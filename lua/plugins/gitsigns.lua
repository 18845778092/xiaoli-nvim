-- gitsigns

return {
  'lewis6991/gitsigns.nvim',
  event = 'BufRead',
  config = function()
    local border = require('core.custom-style').border
    require('gitsigns').setup({
      current_line_blame = true,
      current_line_blame_opts = { delay = 0 },
      current_line_blame_formatter = 'commit: <abbrev_sha>, <author>, <author_time:%R> - <summary>',
      preview_config = {
        border = border,
        style = 'minimal',
        relative = 'cursor',
        row = 1,
        col = 1,
      },
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
          vim.g.gitsigns_blame_open = true
          gitsigns.blame()
        end)
        map('n', 'rh', gitsigns.reset_hunk)
        -- Navigation
        map('n', ']c', function()
          gitsigns.nav_hunk('next')
        end)
        map('n', '[c', function()
          gitsigns.nav_hunk('prev')
        end)
      end,
    })
  end,
}
