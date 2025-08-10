local function get_insert_line()
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

return {
  'piersolenski/import.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('import').setup({
      picker = 'telescope',
      insert_at_top = true,
      custom_languages = {
        {
          -- The filetypes that ripgrep supports (find these via `rg --type-list`)
          extensions = { 'js', 'ts', 'vue' },
          -- The Vim filetypes
          filetypes = { 'vue' },
          -- Optionally set a line other than 1
          insert_at_line = get_insert_line, ---@type function|number,
          -- The regex pattern for the import statement
          regex = [[^(?:import(?:[\"'\s]*([\w*{}\n, ]+)from\s*)?[\"'\s](.*?)[\"'\s].*)]],
        },
      },
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>fi', function()
          require('import').pick()
        end, { desc = 'Import' })
      end,
    })
  end,
}
