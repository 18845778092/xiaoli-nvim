local M = {}
local winblend = 30
local Terminal = require('toggleterm.terminal').Terminal

-- 全局终端实例存储
_G.terminal_instances = _G.terminal_instances or {}

-- 动态创建终端的函数
local function create_terminal(count, cmd, extra_opts)
  local border = require('core.custom-style').border

  local opts = {
    count = count,
    direction = 'float',
    float_opts = {
      border = border,
    },
  }

  if cmd then
    opts.cmd = cmd
  end

  if extra_opts then
    opts = vim.tbl_deep_extend('force', opts, extra_opts)
  end

  return Terminal:new(opts)
end

-- 创建或获取终端实例
function M.get_or_create_terminal(key, count, cmd, extra_opts)
  local current_dir = vim.fn.getcwd()

  if _G.terminal_instances[key] and _G.terminal_instances[key].dir == current_dir then
    return _G.terminal_instances[key]
  end

  -- 创建新的终端实例
  local terminal = create_terminal(count, cmd, extra_opts)
  _G.terminal_instances[key] = terminal

  return terminal
end

function M.recreate_all_terminals()
  _G.terminal_instances = {}
end

-- 普通终端
function M.toggle_normal_term()
  local term = M.get_or_create_terminal('normal', 1, nil, {
    float_opts = {
      winblend = winblend,
    },
  })
  term:toggle()
end

-- Lazygit 终端
function M.toggle_lazygit()
  local term = M.get_or_create_terminal('lazygit', 2, 'lazygit', {
    dir = 'git_dir',
    float_opts = {
      winblend = winblend,
      width = function()
        return math.floor(vim.o.columns * 0.9)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.9)
      end,
    },
    env = {
      LG_CONFIG_FILE = os.getenv('HOME') .. '/.config/lazygit/config.yml',
    },
    close_on_exit = true,
    on_exit = function(term)
      vim.schedule(function()
        if term:is_open() then
          term:close()
        end
      end)
    end,
  })
  term:toggle()
end

-- Yazi 终端
function M.toggle_yazi()
  local term = M.get_or_create_terminal('yazi', 3, 'yazi', {
    float_opts = {
      width = function()
        return math.floor(vim.o.columns * 0.9)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.9)
      end,
    },
    close_on_exit = true,
    on_exit = function(term)
      vim.schedule(function()
        if term:is_open() then
          term:close()
        end
      end)
    end,
  })
  term:toggle()
end

-- 设置全局函数
function M.setup_global_functions()
  M.recreate_all_terminals()
  _G._NORMAL_TERM_TOGGLE = M.toggle_normal_term
  _G._LAZYGIT_TOGGLE = M.toggle_lazygit
  _G._YAZI_TOGGLE = M.toggle_yazi
end

-- 预热终端
function M.warmup_terminals()
  local normal_term = M.get_or_create_terminal('normal', 1, nil, {
    float_opts = {
      winblend = winblend,
    },
  })

  if normal_term and normal_term.spawn then
    normal_term:spawn()
  end
end

-- 初始化
function M.init_and_warmup()
  M.setup_global_functions()
  M.warmup_terminals()
end

return M
