local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

map({ 'v', 'n' }, 'J', '5j')
map({ 'v', 'n' }, 'K', '5k')
map({ 'x', 'o', 'n' }, 'H', '^')
map({ 'x', 'o', 'n' }, 'L', 'g_')
map('n', '<C-e>', '3<C-e>')
map('n', '<C-y>', '3<C-y>')

map({ 'x', 'o' }, 'w', 'iw')
map({ 'x', 'o' }, 'ii', 'i{')
map({ 'x', 'o' }, 'ai', 'a{')
map({ 'x', 'o' }, 'b', 'i(')
-- ie 文本对象
map('v', 'ie', '<Esc>ggVG')
map('o', 'ie', ':normal! ggVG<CR>')

map('n', '<leader>s', require('helper.smart-select-block'))
map('n', '<leader>a', 'za')

map('n', '<leader>nh', ':nohl<CR>') -- 取消高亮
map('n', '<leader>hh', '<C-w>v') -- 水平新增窗口
map('n', '<leader>vv', '<C-w>s') -- 垂直新增窗口
map('n', '<leader>ll', '"ayiwoconsole.log(\'<C-R>a:\', <C-R>a);<Esc>') -- Auto log
-- map('n', '<leader>e', vim.diagnostic.open_float)

-- 禁用默认高亮
map('n', 'f', '<Nop>')
map('n', 'F', '<Nop>')
map('n', 't', '<Nop>')
map('n', 'T', '<Nop>')

map('i', 'jk', '<Esc>')
map({ 'n', 'i' }, '<D-s>', function()
  vim.cmd('w')
end)

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
