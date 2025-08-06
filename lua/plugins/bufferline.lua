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
  local close_helper = require('helper.close-helper')
  local maybe_close_diffview = close_helper.maybe_close_diffview
  local maybe_close_gitsigns_blame = close_helper.maybe_close_gitsigns_blame

  if maybe_close_diffview() then
    return
  end

  if maybe_close_gitsigns_blame() then
    return
  end

  close_buffer_and_goto_next()
end

return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local color_table = require('core.custom-style').color_table

    vim.opt.termguicolors = true
    local selectedColor = '#4792a8'
    local visibleColor = color_table.current_index
    local indicatorColor = '#fde047'
    local pickFgColor = color_table.light_green
    local visibleFgColor = '#e2e8f0'
    local errorFgColor = '#ffffff'
    local warningFgColor = '#ffffff'
    local infoFgColor = '#ffffff'
    local hintFgColor = '#ffffff'
    require('bufferline').setup({
      options = {
        max_name_length = 30, -- 文件名最大长度
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
        separator_style = 'slope', -- slant , slope
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icons = {
            error = ' ',
            warning = ' ',
            info = ' ',
            hint = '󰚩 ',
          }
          local result = {}
          for severity, count in pairs(diagnostics_dict) do
            if count > 0 then
              table.insert(result, icons[severity] .. count)
            end
          end

          return table.concat(result, ' ')
        end,
      },
      highlights = {
        buffer = {},
        buffer_visible = {
          fg = visibleFgColor,
          bg = visibleColor,
        },
        buffer_selected = {
          bg = selectedColor,
          bold = true,
        },
        separator = {},
        separator_visible = {
          bg = visibleColor,
        },
        separator_selected = {
          bg = selectedColor,
          bold = true,
        },
        modified = {
          fg = indicatorColor,
        },
        modified_visible = {
          fg = indicatorColor,
          bg = visibleColor,
        },
        modified_selected = {
          fg = indicatorColor,
          bg = selectedColor,
          -- No need for bold!
        },
        error = {
          fg = errorFgColor,
        },
        warning = {
          fg = warningFgColor,
        },
        info = {
          fg = infoFgColor,
        },
        hint = {
          fg = hintFgColor,
        },
        error_selected = {
          fg = errorFgColor,
          bg = selectedColor,
          bold = true,
        },
        warning_selected = {
          fg = warningFgColor,
          bg = selectedColor,
          bold = true,
        },
        info_selected = {
          fg = infoFgColor,
          bg = selectedColor,
          bold = true,
        },
        hint_selected = {
          fg = hintFgColor,
          bg = selectedColor,
          bold = true,
        },
        error_visible = {
          fg = errorFgColor,
          bg = visibleColor,
        },
        warning_visible = {
          fg = warningFgColor,
          bg = visibleColor,
        },
        info_visible = {
          fg = infoFgColor,
          bg = visibleColor,
        },
        hint_visible = {
          fg = hintFgColor,
          bg = visibleColor,
        },
        error_diagnostic = {
          fg = errorFgColor,
        },
        warning_diagnostic = {
          fg = warningFgColor,
        },
        info_diagnostic = {
          fg = infoFgColor,
        },
        hint_diagnostic = {
          fg = hintFgColor,
        },
        error_diagnostic_selected = {
          fg = errorFgColor,
          bg = selectedColor,
          bold = true,
        },
        warning_diagnostic_selected = {
          fg = warningFgColor,
          bg = selectedColor,
          bold = true,
        },
        info_diagnostic_selected = {
          fg = infoFgColor,
          bg = selectedColor,
          bold = true,
        },
        hint_diagnostic_selected = {
          fg = hintFgColor,
          bg = selectedColor,
          bold = true,
        },
        error_diagnostic_visible = {
          fg = errorFgColor,
          bg = visibleColor,
        },
        warning_diagnostic_visible = {
          fg = warningFgColor,
          bg = visibleColor,
        },
        info_diagnostic_visible = {
          fg = infoFgColor,
          bg = visibleColor,
        },
        hint_diagnostic_visible = {
          fg = hintFgColor,
          bg = visibleColor,
        },
        pick = {
          fg = pickFgColor,
        },
        pick_selected = {
          fg = pickFgColor,
          bg = selectedColor,
          bold = true,
        },
        pick_visible = {
          fg = pickFgColor,
          bg = visibleColor,
        },
      },
    })

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
