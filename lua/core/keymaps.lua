vim.g.mapleader = " "
local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end


-- Ack
--vim.keymap.set("n", "<leader>g", ":Ack!<Space>", { silent = false })

-- Run javascript
-- map('n', '<F5>', '<CMD>!node %<CR>')
-- map('n', '<F2>', '<CMD>Git blame<CR>')

-- Git diffview
-- map('n', '<leader>d', '<CMD>Git<CR>')
-- map('n', '<leader>h', '<CMD>DiffviewFileHistory<CR>')
-- map('n', '<leader>ch', '<CMD>DiffviewFileHistory %<CR>')
-- map('n', '<leader>gd', '<CMD>DiffviewOpen<CR>')
-- map('n', '<leader>gc', '<CMD>DiffviewClose<CR>')


map({ 'v', 'n' }, 'J', '5j')
map({ 'v', 'n' }, 'K', '5k')



-- 快捷操作
map({ 'v', 'o' }, 'w', 'iw')
map({ 'v', 'o' }, 'ii', 'i{')
map({ 'v', 'o' }, 'b', 'i(')
map({ 'v', 'o', 'n' }, 'H', '^')
map({ 'v', 'o', 'n' }, 'L', 'g_')

map('n', '<leader>s', 'V$%')
map('n', '<leader>a', 'za')
map('v', 'ie', '<Esc>ggVG')

-- 取消高亮
map("n", "<leader>nh", ":nohl<CR>")

map("n", "<leader>vv", "<C-w>v") -- 水平新增窗口
map("n", "<leader>hv", "<C-w>s") -- 垂直新增窗口
--
-- 窗口光标移动 左右
map('n', '<C-[>', '<C-W>h')
map('n', '<C-]>', '<C-W>l')

-- 禁用默认高亮
map('n', 'f', '<Nop>')
map('n', 'F', '<Nop>')
map('n', 't', '<Nop>')
map('n', 'T', '<Nop>')

-- Auto log
map('n', '<leader>ll', '"ayiwoconsole.log(\'<C-R>a:\', <C-R>a);<Esc>')

-- map("n", "<leader>w", ":w<CR>") -- 保存
