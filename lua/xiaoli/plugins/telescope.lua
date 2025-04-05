return {
  'nvim-telescope/telescope.nvim',
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
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
          },
        },
        sorting_strategy = 'ascending',
        file_ignore_patterns = { 'node_modules' },
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
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
            },
          },
        },
      },
    })

    telescope.load_extension('live_grep_args')
    telescope.load_extension('ui-select')

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<C-f>', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
    keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Fuzzy find recent files' })
    keymap.set('n', '<leader>fw', '<cmd>Telescope live_grep<cr>', { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', { desc = 'Find string under cursor in cwd' })
    keymap.set('n', '<leader>ft', '<cmd>Telescope colorscheme<cr>', { desc = 'Fuzzy find colorschemes' })

    local live_grep_args_shortcuts = require('telescope-live-grep-args.shortcuts')
    -- keymap.set(
    --   'n',
    --   '<leader>a',
    --   live_grep_args_shortcuts.grep_word_under_cursor,
    --   { desc = 'Find string under cursor in live grep' }
    -- )
  end,
}
