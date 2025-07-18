-- window navigator

return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<c-a>', '<cmd>TmuxNavigateLeft<cr>' },
    { '<c-s>', '<cmd>TmuxNavigateRight<cr>' },
  },
}
