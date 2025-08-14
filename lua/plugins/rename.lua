-- rename

return {
  'smjonas/inc-rename.nvim',
  enabled = true,
  config = function()
    require('inc_rename').setup({
      -- the name of the command
      cmd_name = 'IncRename',
      -- the highlight group used for highlighting the identifier's new name
      hl_group = 'Substitute',
      -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
      preview_empty_name = true,
      -- whether to display a `Renamed m instances in n files` message after a rename operation
      show_message = true,
      -- whether to save the "IncRename" command in the commandline history (set to false to prevent issues with
      -- navigating to older entries that may arise due to the behavior of command preview)
      save_in_cmdline_history = true,
      -- the type of the external input buffer to use (currently supports "dressing" or "snacks")
      input_buffer_type = nil,
      -- callback to run after renaming, receives the result table (from LSP handler) as an argument
      post_hook = nil,
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>rn', ':IncRename ')
      end,
    })
  end,
}
