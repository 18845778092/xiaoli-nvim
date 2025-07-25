-- DiffviewXxx cmd

return {
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('diffview').setup({
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
        map('n', '<leader>gc', '<CMD>DiffviewClose<CR>')
      end,
    })
  end,
}
