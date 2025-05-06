return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
  },
  event = 'VimEnter',
  config = function()
    local status, telescope = pcall(require, 'telescope')
    if not status then
      return
    end

    local lga_actions = require('telescope-live-grep-args.actions')

    telescope.setup({
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
      defaults = {
        -- layout_strategy = 'horizontal',
        layout_strategy = 'vertical',
        layout_config = {
          -- 水平
          horizontal = {
            width = 0.9,
            preview_width = 0.3,
            preview_cutoff = 1,
            -- prompt_position = 'top',
          },
          vertical = {
            width = 0.9,
            preview_cutoff = 1,   -- 总是显示预览
            preview_height = 0.5, -- 预览窗口占50%高度
            -- mirror = true,        -- 将预览放在下方
            prompt_position = 'bottom',
          },
        },
        sorting_strategy = 'ascending',
        file_ignore_patterns = { 'node_modules', 'public/', 'dist' },
      },
      extensions = {
        file_browser = {
          theme = 'ivy',
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ['i'] = {
              -- your custom insert mode mappings
            },
            ['n'] = {
              -- your custom normal mode mappings
            },
          },
        },
        live_grep_args = {
          auto_quoting = false, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = {          -- extend mappings
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              -- ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
              ['<C-p>'] = lga_actions.quote_prompt({ postfix = ' --fixed-strings --ignore-case' }), -- 添加固定字符串搜索
            },
            n = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              -- ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
              ['<C-p>'] = lga_actions.quote_prompt({ postfix = ' -F --ignore-case' }), -- 添加固定字符串搜索
            },
          },
        },
      },
    })

    telescope.load_extension('live_grep_args')
    telescope.load_extension('ui-select')

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- local live_grep_args_shortcuts = require('telescope-live-grep-args.shortcuts')
    keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = 'Fuzzy find recent files' })
    keymap.set('n', '<leader>fm', require('telescope.builtin').marks, { desc = 'show all marks' })
    -- keymap.set('n', '<leader>fw', '<cmd>Telescope live_grep<cr>', { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fw', function()
      require('telescope').extensions.live_grep_args.live_grep_args({
        default_text = '',                                        -- 默认搜索词
        additional_args = { '--fixed-strings', '--ignore-case' }, -- 附加参数
      })
    end, { desc = 'Find string in cwd with args' })
    -- 添加符号搜索快捷键 使用coc的时候关闭
    -- keymap.set('n', '<C-f>', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
    -- vim.keymap.set('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>',
    --   { desc = 'Search symbols in current file' })
  end,
}
