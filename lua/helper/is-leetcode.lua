local function is_leetcode_context()
  -- 检查启动参数中是否包含 leetcode.nvim
  local args = vim.v.argv
  for _, arg in ipairs(args) do
    if string.match(arg, 'leetcode%.nvim') then
      return true
    end
  end

  -- 检查当前工作目录是否包含 leetcode.nvim
  local cwd = vim.fn.getcwd()
  if string.match(cwd, 'leetcode%.nvim') then
    return true
  end

  return false
end

return is_leetcode_context
