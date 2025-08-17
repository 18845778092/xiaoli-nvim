-- Edit snippets

return {
  'chrisgrieser/nvim-scissors',
  dependencies = 'nvim-telescope/telescope.nvim', -- if using telescope
  config = function()
    local border = require('core.custom-style').border
    require('scissors').setup({
      snippetDir = vim.fn.stdpath('config') .. '/snippets',
      editSnippetPopup = {
        height = 0.4, -- relative to the window, between 0-1
        width = 0.6,
        border = border,
        keymaps = {
          -- if not mentioned otherwise, the keymaps apply to normal mode
          cancel = 'q',
          saveChanges = '<CR>', -- alternatively, can also use `:w`
          goBackToSearch = '<BS>',
          deleteSnippet = '<C-BS>',
          duplicateSnippet = '<C-d>',
          openInFile = '<C-o>',
          insertNextPlaceholder = '<C-p>', -- insert & normal mode
          showHelp = '?',
        },
      },
    })

    vim.api.nvim_create_user_command('AddSnippets', function(opts)
      if opts.range > 0 then
        vim.cmd(':\'<,\'> ScissorsAddNewSnippet')
      else
        require('scissors').addNewSnippet()
      end
    end, {
      range = true,
      desc = 'Smart add snippet with optional range',
    })

    vim.api.nvim_create_user_command('EditSnippets', require('scissors').editSnippet, { desc = 'Edit snippets' })
  end,
}
