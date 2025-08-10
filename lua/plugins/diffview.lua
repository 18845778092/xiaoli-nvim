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
          require('helper.theme.plugins.diffview').reset()
          vim.g.diffview_open_flag = true
          -- 自动聚焦diff页面
          local function auto_focus()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              local buf_name = vim.api.nvim_buf_get_name(buf)
              local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
              if
                filetype ~= 'DiffviewFiles'
                and filetype ~= 'DiffviewFileHistory'
                and buf_name:match('diffview://')
                and not buf_name:match('%.git/')
              then
                vim.api.nvim_set_current_win(win)
                break
              end
            end
          end
          vim.schedule(auto_focus)
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
