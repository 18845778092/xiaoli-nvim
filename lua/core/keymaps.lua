vim.g.mapleader = ' '
local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

map({ 'v', 'n' }, 'J', '5j')
map({ 'v', 'n' }, 'K', '5k')

-- 快捷操作
map({ 'v', 'o' }, 'w', 'iw')
map({ 'v', 'o' }, 'ii', 'i{')
map({ 'v', 'o' }, 'ai', 'a{')
map({ 'v', 'o' }, 'b', 'i(')
map({ 'v', 'o', 'n' }, 'H', '^')
map({ 'v', 'o', 'n' }, 'L', 'g_')

map('n', '<leader>s', require('helper.smart-select-block'))

map('n', '<leader>a', 'za')

map('v', 'ie', '<Esc>ggVG') -- 全选整个文件内容
map('n', 'die', 'ggdG') -- 删除整个文件内容
map('n', 'yie', 'ggyG') -- 复制整个文件内容
map('n', 'cie', 'ggcG') --

-- 取消高亮
map('n', '<leader>nh', ':nohl<CR>')

map('n', '<leader>hh', '<C-w>v') -- 水平新增窗口
map('n', '<leader>vv', '<C-w>s') -- 垂直新增窗口
--

-- 禁用默认高亮
map('n', 'f', '<Nop>')
map('n', 'F', '<Nop>')
map('n', 't', '<Nop>')
map('n', 'T', '<Nop>')

-- Auto log
map('n', '<leader>ll', '"ayiwoconsole.log(\'<C-R>a:\', <C-R>a);<Esc>')
map('i', 'jk', '<Esc>')

map({ 'n', 'i' }, '<D-s>', function()
  vim.cmd('w')
end)

vim.keymap.set('n', '<leader>ls', ':SessionManager load_session<CR>', { desc = '加载会话', silent = true })
map('n', '<space>e', vim.diagnostic.open_float)

vim.keymap.set('n', '=', function()
  vim.cmd('WindowsDisableAutowidth')
  vim.cmd('vertical resize +2')
end, { desc = '增加窗口左右宽度' })
vim.keymap.set('n', '-', function()
  vim.cmd('WindowsDisableAutowidth')
  vim.cmd('vertical resize -2')
end, { desc = '减少左右宽度' })
vim.keymap.set('n', '<C-=>', function()
  vim.cmd('WindowsDisableAutowidth')
  vim.cmd('resize +2')
end, { desc = '增加窗口上下高度' })
vim.keymap.set('n', '<C-->', function()
  vim.cmd('WindowsDisableAutowidth')
  vim.cmd('resize -2')
end, { desc = '减少窗口上下高度' })
