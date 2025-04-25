return {
  'hedyhli/outline.nvim',
  config = function()
    require('outline').setup({
      outline_window = {
        width = 20,
        position = 'right',
        show_numbers = true,
        show_guides = true,
        auto_preview = false,
      },
      symbol_folding = {
        autofold_depth = 2,
      },
      preview_window = {
        auto_preview = true,
      },
      keymaps = {
        -- 禁用默认的 K 映射
        toggle_preview = {},
        close = {},
        fold = 'L',
        unfold = 'l',
      },
      symbols = {
        icons = {
          File = { icon = 'File', hl = 'Identifier' },
          Module = { icon = 'M', hl = 'Include' },
          Namespace = { icon = 'Ns', hl = 'Include' },
          Package = { icon = 'Package', hl = 'Include' },
          Class = { icon = 'Class', hl = 'Type' },
          Method = { icon = 'Fn', hl = 'Function' },
          Property = { icon = 'Prop', hl = 'Identifier' },
          Field = { icon = 'Field', hl = 'Identifier' },
          Constructor = { icon = 'Constructor', hl = 'Special' },
          Enum = { icon = 'Enum', hl = 'Type' },
          Interface = { icon = 'I', hl = 'Type' },
          Function = { icon = 'Fn', hl = 'Function' },
          Variable = { icon = 'V', hl = 'Constant' },
          Constant = { icon = 'Const', hl = 'Constant' },
          String = { icon = 'Str', hl = 'String' },
          Number = { icon = 'Num', hl = 'Number' },
          Boolean = { icon = 'Bool', hl = 'Boolean' },
          Array = { icon = 'Array', hl = 'Constant' },
          Object = { icon = 'Object', hl = 'Type' },
          -- Key = { icon = '🔐', hl = 'Type' },
          Null = { icon = 'NULL', hl = 'Type' },
          EnumMember = { icon = 'Enum', hl = 'Identifier' },
          Struct = { icon = 'S', hl = 'Structure' },
          Event = { icon = 'Event', hl = 'Type' },
          Operator = { icon = '+', hl = 'Identifier' },
          TypeParameter = { icon = '𝙏', hl = 'Identifier' },
          Component = { icon = 'Comp', hl = 'Function' },
          -- Fragment = { icon = '󰅴', hl = 'Constant' },
          TypeAlias = { icon = 'Type', hl = 'Type' },
          Parameter = { icon = 'Param', hl = 'Identifier' },
          StaticMethod = { icon = 'Static ', hl = 'Function' },
          -- Macro = { icon = ' ', hl = 'Function' },
        },
      },
    })

    -- 添加自定义快捷键
    vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = '切换大纲视图' })
  end,
}
