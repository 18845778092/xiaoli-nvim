return {
  'backdround/global-note.nvim',
  config = function()
    require('global-note').setup({
      filename = 'global.md',
      directory = '~/notes/',

      additional_presets = {
        projects = {
          filename = 'projects-to-do.md',
          title = 'List of projects',
          command_name = 'ProjectsNote',
          -- All not specified options are used from the root.
        },

        food = {
          filename = 'want-to-eat.md',
          title = 'List of food',
          command_name = 'FoodNote',
          -- All not specified options are used from the root.
        },
      },
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<C-m>', function()
          require('global-note').toggle_note()
        end, { desc = '全局note' })
      end,
    })

    -- Functions to toggle notes:
    -- require('global-note').toggle_note()
    -- require('global-note').toggle_note('projects')
    -- require('global-note').toggle_note('food')
  end,
}
