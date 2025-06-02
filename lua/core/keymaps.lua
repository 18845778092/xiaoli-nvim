vim.g.mapleader = ' '
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

map('v', 'ie', '<Esc>ggVG') -- 全选整个文件内容
map('n', 'die', 'ggdG') -- 删除整个文件内容
map('n', 'yie', 'ggyG') -- 复制整个文件内容

-- 取消高亮
map('n', '<leader>nh', ':nohl<CR>')

map('n', '<leader>vv', '<C-w>v') -- 水平新增窗口
map('n', '<leader>hv', '<C-w>s') -- 垂直新增窗口
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
map('i', 'jk', '<Esc>')

-- map("n", "<leader>w", ":w<CR>") -- 保存

------------------------------coc配置
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
local keyset = vim.keymap.set
keyset('i', '<TAB>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset('i', '<cr>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset('n', 'gh', '<CMD>lua _G.show_docs()<CR>', { silent = true })
keyset('i', '<c-i>', 'coc#refresh()', { silent = true, expr = true }) -- ctrl+i触发补全 类似vscode cmd+i
-- keyset('n', '<space>y', '<CMD>CocList -A --normal yank<CR>', { silent = true }) -- coc粘贴列表 暂时用neoclip代替
map('n', '<space>e', vim.diagnostic.open_float)
map('n', 'gd', '<Plug>(coc-definition)')
map('n', '<leader>ca', '<Plug>(coc-codeaction-line)')
map('n', 'rn', '<Plug>(coc-rename)')
map('n', '<c-f>', ':CocCommand fzf-preview.ProjectFiles --add-fzf-arg=--ignore-case<CR>') -- 文件名搜索 忽略大小写
map('n', '<leader>fs', ':CocCommand fzf-preview.Lines<CR>') -- 当前文件中根据符号搜索内容
-- map('n', '<leader>fm', ':CocCommand fzf-preview.Marks<CR>')         -- 当前mark  暂用telescope的
map('n', '<leader>fr', ':CocCommand fzf-preview.CocReferences<CR>') -- 查找全部引用
map('n', '<leader>fc', ':CocCommand fzf-preview.Changes<CR>') -- 查看当前文件变更内容
------------------------------coc配置

map('n', '<leader>mm', '<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>')
vim.keymap.set('n', '<leader>ls', ':SessionManager load_session<CR>', { desc = '加载会话', silent = true })

-- 添加跳转快捷键
vim.keymap.set('n', '<leader>q', '<Cmd>BufferLinePickClose<CR>', { noremap = true })
