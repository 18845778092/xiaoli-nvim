return {
  -- get project abs-path by git
  get_project_root = function()
    local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    if vim.v.shell_error == 0 then
      return git_root
    else
      return vim.fn.getcwd()
    end
  end,
}
