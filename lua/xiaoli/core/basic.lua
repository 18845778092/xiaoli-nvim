local opt = vim.opt

-- 行号
opt.relativenumber = false
opt.number = true

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"
-- vim.cmd [[colorscheme tokyonight-moon]]
vim.cmd [[colorscheme kanagawa-wave]]
-- local g = vim.g
-- local o = vim.o
-- local opt = vim.opt

-- -- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

-- o.termguicolors = true
-- -- o.background = 'dark'

-- -- Do not save when switching buffers
-- -- o.hidden = true

-- -- Decrease update time
-- o.timeoutlen = 500
-- o.updatetime = 200

-- -- Number of screen lines to keep above and below the cursor
-- o.scrolloff = 8

-- -- Better editor UI
-- o.number = true
-- o.numberwidth = 2
-- o.relativenumber = false
-- o.signcolumn = 'yes'
-- o.cursorline = true

-- -- Better editing experience
-- o.expandtab = true
-- o.smarttab = true
-- o.cindent = true
-- o.autoindent = true
-- o.wrap = true
-- o.textwidth = 300
-- o.tabstop = 2
-- o.shiftwidth = 2
-- o.softtabstop = -1 -- If negative, shiftwidth value is used
-- o.list = true
-- o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- -- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- -- o.formatoptions = 'qrn1'

-- -- Makes neovim and host OS clipboard play nicely with each other
-- opt.clipboard:append('unnamedplus')
-- opt.fillchars = { eob = ' ' }

-- -- Case insensitive searching UNLESS /C or capital in search
-- o.ignorecase = true
-- o.smartcase = true

-- -- Undo and backup options
-- o.backup = false
-- o.writebackup = false
-- o.undofile = true
-- o.swapfile = false
-- -- o.backupdir = '/tmp/'
-- -- o.directory = '/tmp/'
-- -- o.undodir = '/tmp/'

-- -- Remember 50 items in commandline history
-- o.history = 50

-- -- Better buffer splitting
-- o.splitright = true
-- o.splitbelow = true

-- -- Preserve view while jumping
-- -- BUG This option causes an error!
-- -- o.jumpoptions = 'view'

-- -- BUG: this won't update the search count after pressing `n` or `N`
-- -- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- -- o.lazyredraw = true

-- -- Better folds (don't fold by default)
-- -- o.foldmethod = 'indent'
-- -- o.foldlevelstart = 99
-- -- o.foldnestmax = 3
-- -- o.foldminlines = 1
-- --
-- opt.mouse = 'a'

-- -- Map <leader> to space
-- g.mapleader = ' '
-- g.maplocalleader = ' '

-- o.modifiable = true
