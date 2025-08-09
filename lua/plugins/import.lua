return {
  'piersolenski/import.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('import').setup({
      picker = 'telescope',
      insert_at_top = false,
    })

    function get_insert_line()
      if vim.bo.filetype ~= 'vue' then
        return 1
      end

      local bufnr = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      for i, line in ipairs(lines) do
        if line:match('<script[^>]*>') then
          return i + 1 -- script 标签的下一行
        end
      end
      return 1 -- 没找到 script 标签，默认插入到第一行
    end

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>fi', function()
          local current_pos = vim.api.nvim_win_get_cursor(0)
          local line = get_insert_line()
          vim.api.nvim_win_set_cursor(0, { line, 0 })
          local group = vim.api.nvim_create_augroup('ImportReturn', { clear = true })
          vim.api.nvim_create_autocmd('InsertLeave', {
            group = group,
            once = true,
            callback = function()
              vim.defer_fn(function()
                vim.api.nvim_win_set_cursor(0, current_pos)
                vim.api.nvim_del_augroup_by_id(group)
              end, 50)
            end,
          })

          require('import').pick()
        end, { desc = 'Import' })
      end,
    })
  end,
}
