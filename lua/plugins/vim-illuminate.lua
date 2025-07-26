-- highlighting other uses of the word under the cursor

return {
  'RRethy/vim-illuminate',
  config = function()
    local illuminate = require('illuminate')
    local color_table = require('core.custom-style').color_table

    illuminate.configure({
      providers = {
        'lsp',
        'treesitter',
      },
      delay = 30,
      modes_denylist = { 'v', 'V', '\22' }, -- 在可视模式下禁用
    })

    local function illuminate_goto(direction)
      if direction == 'next' then
        illuminate.goto_next_reference(false)
      else
        illuminate.goto_prev_reference(false)
      end

      vim.cmd('normal! zz') -- 居中显示
    end

    vim.keymap.set('n', ']]', function()
      illuminate_goto('next')
    end, { desc = '下一个引用' })
    vim.keymap.set('n', '[[', function()
      illuminate_goto('prev')
    end, { desc = '上一个引用' })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.api.nvim_set_hl(0, 'IlluminatedWordText', {
          bg = color_table.cursor_line_color,
          bold = true,
        })
        vim.api.nvim_set_hl(0, 'IlluminatedWordRead', {
          bg = color_table.cursor_line_color,

          bold = true,
        })
        vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', {
          bg = color_table.cursor_line_color,
          bold = true,
        })
      end,
    })
  end,
}
