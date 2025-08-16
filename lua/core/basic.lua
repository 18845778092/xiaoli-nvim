local color_table = require('core.custom-style').color_table
local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true
opt.autoread = true -- 自动重载变更
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.jumpoptions = 'stack' -- gd ctrl+o 跳转模型
opt.swapfile = false
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.cursorcolumn = true
vim.opt.cursorline = true

-- - "t"  -- 不根据 textwidth 自动换行
-- - "c"  -- 不自动换行注释
-- - "r"  -- 不自动插入注释
-- - "o"  -- 不自动插入注释（使用o/O时）
-- - "q"  -- 允许使用gq格式化注释
-- - "l"  -- 不自动换行长行
-- - "a"  -- 不自动格式化段落
vim.api.nvim_create_autocmd({ 'FileType' }, {
  command = 'set formatoptions-=ro',
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  command = 'if mode() != \'c\' | checktime | endif',
})
-- -- 文件变更时的通知
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  pattern = '*',
  command = 'echohl WarningMsg | echo \'文件已被外部程序修改\' | echohl None',
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'help' then
      vim.cmd('wincmd L') -- 右侧打开
    end
  end,
})
-- 防止包裹
opt.wrap = false

-- 光标行
-- 启用光标行高亮
opt.cursorline = true
--  注释颜色

-- 启用鼠标
opt.mouse:append('a')

-- 系统剪贴板
opt.clipboard:append('unnamedplus')

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

opt.foldlevel = 99
opt.foldlevelstart = 99
-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = 'yes'

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

-- -- Better folds (don't fold by default)
-- -- o.foldmethod = 'indent'
-- -- o.foldlevelstart = 99
-- -- o.foldnestmax = 3
-- -- o.foldminlines = 1
-- --
-- opt.mouse = 'a'

-- o.modifiable = true

-- 完全禁用窗口自动跳转
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd([[
      nnoremap <silent> <Esc> <Esc>
      vnoremap <silent> <Esc> <Esc>
      inoremap <silent> <Esc> <Esc>
    ]])
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'highlight after yank',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = 'CustomYankHighlight',
      timeout = 500,
    })
  end,
})
