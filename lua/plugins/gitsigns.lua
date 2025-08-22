-- gitsigns

return {
  'lewis6991/gitsigns.nvim',
  event = 'BufRead',
  config = function()
    local border = require('core.custom-style').border
    local addChar = '┃'
    local deleteChar = '_'
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
        add = { text = addChar },
        change = { text = addChar },
        delete = { text = deleteChar },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signs_staged = {
        add = { text = addChar },
        change = { text = addChar },
        delete = { text = deleteChar },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
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
        map('n', 'nc', function()
          gitsigns.nav_hunk('next')
        end)
        map('n', 'pc', function()
          gitsigns.nav_hunk('prev')
        end)
        map('n', 'rl', function()
          local cursor_line = vim.fn.line('.')
          gitsigns.reset_hunk({ cursor_line, cursor_line })
        end)
      end,
    })
  end,
}
