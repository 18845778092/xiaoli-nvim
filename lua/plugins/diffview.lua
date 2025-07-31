-- DiffviewXxx cmd

return {
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    vim.opt.fillchars = {
      diff = '╱',
    }
    require('diffview').setup({
      hooks = {
        view_opened = function(view)
          local diff_green = '#4e5c34'
          local diff_red = '#3d1a1a'
          vim.api.nvim_set_hl(0, 'DiffDelete', {
            bg = 'NONE',
            fg = '#474849',
          })
          vim.api.nvim_set_hl(0, 'DiffAdd', {
            bg = diff_green,
          })
          vim.api.nvim_set_hl(0, 'DiffText', {
            fg = 'NONE',
            bg = diff_green,
          })
          vim.g.diffview_open_flag = true
        end,
        view_closed = function(view)
          vim.g.diffview_open_flag = false
        end,
      },
      enhanced_diff_hl = true,
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              follow = true, -- 跟踪文件重命名
              all = true,
            },
            multi_file = {
              all = true,
            },
          },
        },
      },
    })
    local function map(m, k, v)
      vim.keymap.set(m, k, v, { silent = true })
    end

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        -- Git diffview
        -- map('n', '<leader>d', '<CMD>Git<CR>')
        -- map('n', '<leader>h', '<CMD>DiffviewFileHistory<CR>')
        map('n', '<leader>gh', '<CMD>DiffviewFileHistory %<CR>') -- 当前文件全量历史
        map('n', '<leader>gd', '<CMD>DiffviewOpen<CR>')
      end,
    })
  end,
}
