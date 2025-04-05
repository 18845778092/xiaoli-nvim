return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-a>", "<cmd>TmuxNavigateLeft<cr>" },
    -- { "<C-S-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
    -- { "<C-S-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-s>", "<cmd>TmuxNavigateRight<cr>" },
    -- { "<C-S-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    -- { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
    -- { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
    -- { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
    -- { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
    -- { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
