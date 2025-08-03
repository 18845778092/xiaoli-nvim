-- global replace

return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup({
      engine = 'ripgrep',
      transient = true, -- 临时缓冲区
      keymaps = {
        replace = { n = '<localleader>r' },
        qflist = { n = '' }, --[[ { n = '<localleader>q' }, ]]
        syncLocations = { n = '<localleader>s' },
        syncLine = { n = '<localleader>l' },
        close = { n = '<localleader>c' },
        historyOpen = { n = '<localleader>t' },
        historyAdd = { n = '<localleader>a' },
        refresh = { n = '<localleader>f' },
        openLocation = { n = '<localleader>o' },
        openNextLocation = { n = '<down>' },
        openPrevLocation = { n = '<up>' },
        gotoLocation = { n = '<enter>' },
        pickHistoryEntry = { n = '<enter>' },
        abort = { n = '<localleader>b' },
        help = { n = 'g?' },
        toggleShowCommand = { n = '<localleader>w' },
        swapEngine = { n = '<localleader>e' },
        previewLocation = { n = '<localleader>i' },
        swapReplacementInterpreter = { n = '<localleader>x' },
        applyNext = { n = '<localleader>j' },
        applyPrev = { n = '<localleader>k' },
        syncNext = { n = '<localleader>n' },
        syncPrev = { n = '<localleader>p' },
        syncFile = { n = '<localleader>v' },
        nextInput = { n = '<tab>' },
        prevInput = { n = '<s-tab>' },
      },
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.api.nvim_create_user_command('FindCwd', function()
          vim.cmd('GrugFar')
        end, { desc = 'Find and replace current cwd' })

        vim.api.nvim_create_user_command('FindCurFile', function()
          require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })
        end, { desc = 'Find and replace current file' })

        vim.keymap.set('n', '<leader>fc', '<CMD>FindCwd<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>ff', '<CMD>FindCurFile<CR>', { noremap = true })
      end,
    })
  end,
}
