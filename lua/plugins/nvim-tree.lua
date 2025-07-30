-- file explorer

return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    local function my_on_attach(bufnr)
      local api = require('nvim-tree.api')

      --
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', '<leader>nn', api.tree.toggle)

      -- mini.files like mappings
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('nav parent'))
      vim.keymap.set('n', 'l', api.node.open.preview, opts('open / preview'))

      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('open'))
      vim.keymap.set('n', 'o', api.node.open.edit, opts('open'))
    end

    local glyphs = {
      default = '',
      symlink = '',
      git = {
        unstaged = '',
        staged = 'S',
        unmerged = '',
        renamed = '➜',
        deleted = '',
        untracked = 'U',
        ignored = '◌',
      },
      folder = {
        default = '',
        open = '',
        empty = '',
        empty_open = '',
        symlink = '',
      },
    }

    -- OR setup with some options
    require('nvim-tree').setup({
      on_attach = my_on_attach,
      auto_reload_on_write = true,
      sort_by = 'case_sensitive',
      update_cwd = false,
      update_focused_file = {
        enable = true, -- 改为 true 启用自动聚焦
        update_cwd = false, -- 同时更新工作目录
        ignore_list = {}, -- 不想自动聚焦的文件类型可以加在这里
      },
      view = {
        width = 45,
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = glyphs,
        },
      },
      filters = {
        dotfiles = true,
      },
    })

    -- set keymaps
    -- vim.keymap.set('n', '<leader>ff', '<CMD>NvimTreeToggle<CR>')
    -- vim.keymap.set('n', '<leader>nf', '<CMD>NvimTreeFindFile<CR>')
    -- vim.keymap.set('n', '<leader>bf', '<CMD>NvimTreeFocus<CR>')
  end,
}
