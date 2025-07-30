-- buffer tab

-- 自定义 buffer 关闭函数，确保选择视觉上的下一个
local function close_buffer_and_goto_next()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })

  -- 过滤掉当前要关闭的 buffer
  local other_buffers = {}
  for _, buf in ipairs(buffers) do
    if buf.bufnr ~= current_buf then
      table.insert(other_buffers, buf)
    end
  end

  if #other_buffers == 0 then
    -- 如果没有其他 buffer
    -- vim.cmd('enew')
    vim.cmd('NvimTreeOpen') -- 展示tree
    vim.cmd('bdelete ' .. current_buf)
    return
  end

  -- 找到当前 buffer 在原列表中的位置
  local current_index = nil
  for i, buf in ipairs(buffers) do
    if buf.bufnr == current_buf then
      current_index = i
      break
    end
  end

  if current_index then
    -- 选择下一个 buffer
    local next_buf = nil
    if current_index <= #other_buffers then
      -- 如果不是最后一个，选择下一个位置的 buffer
      next_buf = other_buffers[current_index]
    else
      -- 如果是最后一个，选择前一个
      next_buf = other_buffers[#other_buffers]
    end

    if next_buf then
      vim.api.nvim_set_current_buf(next_buf.bufnr)
    end
  end

  -- 关闭原来的 buffer
  vim.cmd('bdelete ' .. current_buf)
end

local function auto_close_target_buf()
  local maybe_close_diffview = require('helper.close-helper').maybe_close_diffview
  if maybe_close_diffview() then
    return
  end

  close_buffer_and_goto_next()
end

return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require('bufferline').setup({
      options = {
        -- 使用 nvim 内置lsp
        diagnostics = 'nvim_lsp',
        -- 左侧让出 nvim-tree 的位置
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        -- 插入顺序排序
        sort_by = 'insert_at_end',
        show_buffer_close_icons = false,
      },
    })

    -- vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = '下一个 buffer', noremap = true })
    -- vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = '上一个 buffer', noremap = true })
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set(
          'n',
          '<leader>q',
          auto_close_target_buf,
          { desc = '关闭当前buffer选择下一个', noremap = true }
        )
        vim.keymap.set(
          'n',
          '<leader>Q',
          '<CMD>BufferLineCloseOthers<CR>',
          { desc = 'close others buffer', noremap = true }
        )
      end,
    })
  end,
}
