vim.g.mapleader = " "
local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- Basic map
-- map('n', 'qq', '<CMD>q!<CR>')
-- map('n', '<leader>qq', '<CMD>qa!<CR>')
-- map('n', '<leader><cr>', '<CMD>noh<CR>')
-- map('n', '<leader>w', '<CMD>wa<CR>')

-- Tab switch map
-- map('n', '<leader>tn', '<CMD>tabnew<CR>')
-- map('n', '<leader>1', '1gt<CR>')
-- map('n', '<leader>2', '2gt<CR>')
-- map('n', '<leader>3', '3gt<CR>')


-- Smart way to move between windows
-- map('n', '<C-j>', '<C-W>j')
-- map('n', '<C-k>', '<C-W>k')
-- map('n', '<C-h>', '<C-W>h')
-- map('n', '<C-l>', '<C-W>l')

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
map({ 'v', 'n' }, 'H', '^')
map({ 'v', 'n' }, 'L', 'g_')
map('n', 'cH', 'c^')  -- 删除到行首
map('n', 'cL', 'cg_') -- 删除到行尾
map('n', '<leader>s', 'V$%')
-- map('n', '<leader>a', 'zfip')
map('n', '<leader>a', 'za')

map('v', 'ie', 'ggG')

-- 取消高亮
map("n", "<leader>nh", ":nohl<CR>")

map("n", "<leader>vv", "<C-w>v") -- 水平新增窗口
map("n", "<leader>hv", "<C-w>s") -- 垂直新增窗口

map('n', 'f', '<Nop>')
map('n', 'F', '<Nop>')
map('n', 't', '<Nop>')
map('n', 'T', '<Nop>')

-- Auto log
map('n', '<leader>ll', '"ayiwoconsole.log(\'<C-R>a:\', <C-R>a);<Esc>')
-- map("n", "<leader>rn", "vim.lsp.buf.rename")

-- map("n", "<leader>w", ":w<CR>")  -- 保存
