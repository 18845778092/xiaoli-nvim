local M = {}

-- 允许保存session的路径白名单（支持正则表达式）
--          ╒═════════════════════════════════════════════════════════╕
--          │              /a/b  --> /a/b     /a/b/c                │
--          │              /a/b$ --> /a/b     /a/b/c                │
--          │              .*/b$ --> /x/b     /a/b/c                │
--          │              ^c/d$ --> c/b      /a/b/c/d              │
--          ╘═════════════════════════════════════════════════════════╛
local allowed_paths = {}

-- 过滤保存会话的路径
function M.is_path_allowed_save_session(path)
  -- 正则白名单
  for _, pattern in ipairs(allowed_paths) do
    if string.match(path, pattern) then
      return true
    end
  end

  -- -- git仓库保存
  if vim.fn.isdirectory(path .. '/.git') == 1 then
    return true
  end
  --
  -- -- node项目保存
  if vim.fn.filereadable(path .. '/package.json') == 1 then
    return true
  end

  return false
end

return M
