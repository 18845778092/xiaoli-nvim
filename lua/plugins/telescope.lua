-- telescope

return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
  },
  build = 'brew install ripgrep',
  event = 'VimEnter',
  config = function()
    local get_project_root = require('helper.cwd').get_project_root
    local status, telescope = pcall(require, 'telescope')
    if not status then
      return
    end

    telescope.setup({
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
      defaults = {
        layout_strategy = 'horizontal',
        -- layout_strategy = 'vertical',
        layout_config = {
          -- 水平
          horizontal = {
            width = 0.9,
            preview_width = 0.4,
            preview_cutoff = 1,
          },
          vertical = {
            width = 0.9,
            preview_cutoff = 1, -- 总是显示预览
            preview_height = 0.5, -- 预览窗口占50%高度
            -- mirror = true,        -- 将预览放在下方
            prompt_position = 'bottom',
          },
        },
        sorting_strategy = 'ascending',
        file_ignore_patterns = { 'node_modules', 'public/', 'dist', 'js%-debug' },
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
        -- live_grep_args = {
        -- auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        -- mappings = {          -- extend mappings
        --   i = {
        --     ['<C-k>'] = lga_actions.quote_prompt(),
        --     -- ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
        --     ['<C-p>'] = lga_actions.quote_prompt({ postfix = ' --fixed-strings --ignore-case' }), -- 添加固定字符串搜索
        --   },
        --   n = {
        --     ['<C-k>'] = lga_actions.quote_prompt(),
        --     -- ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
        --     ['<C-p>'] = lga_actions.quote_prompt({ postfix = ' -F --ignore-case' }), -- 添加固定字符串搜索
        --   },
        -- },
        -- },
      },
    })

    telescope.load_extension('live_grep_args')
    telescope.load_extension('ui-select')

    local keymap = vim.keymap
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local tele_builtin = require('telescope.builtin')
        keymap.set('n', '<leader>fo', tele_builtin.oldfiles, { desc = 'Fuzzy find recent files' })
        keymap.set('n', '<leader>fm', tele_builtin.marks, { desc = 'show all marks' })
        keymap.set('n', '<leader>fb', tele_builtin.buffers, { desc = 'Lists open buffers in current neovim instance' })
        keymap.set('n', '<C-f>', function()
          tele_builtin.find_files({
            cwd = get_project_root(),
          })
        end, { desc = 'Fuzzy find files in project root' })
        keymap.set('n', '<leader>fs', tele_builtin.lsp_document_symbols, { desc = 'Search symbols in current file' })
        keymap.set('n', '<leader>fw', function()
          telescope.extensions.live_grep_args.live_grep_args({
            cwd = get_project_root(),
            auto_quoting = true,
            default_text = '', -- 默认搜索词
            additional_args = {
              '--fixed-strings',
              '--ignore-case',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
            }, -- 查询参数
          })
        end, { desc = 'Find string in cwd with args' })
      end,
    })
  end,
}
