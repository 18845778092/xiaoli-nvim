local M = {}

function M.get_dashboard_config()
  local function has_content(t)
    for _, value in pairs(t) do
      -- 检查值是否不为空字符串、nil或空白字符
      if value ~= nil and value ~= '' and (type(value) ~= 'string' or value:match('%S')) then
        return true
      end
    end
    return false
  end
  local header = {}

  local git_dashboard = require('git-dashboard-nvim').setup({
    centered = false,
    top_padding = 4,
    bottom_padding = 2,
    hide_cursor = false,
  })

  for _, line in ipairs(git_dashboard) do
    table.insert(header, line)
  end

  if not has_content(header) then
    local banner = vim.deepcopy(require('helper.constant').no_git_repo_found)
    header = banner
    table.insert(header, ' ')
    table.insert(header, 'You are here: ' .. vim.fn.getcwd())
    table.insert(header, ' ')
  end

  local config = {
    disable_move = true, -- boolean default is false disable move key
    theme = 'Hyper',
    config = {
      header = header,
      shortcut = {
        { desc = '󰊳 Lazy Panel', group = '@property', action = 'Lazy', key = '1' },
        {
          desc = ' Mason Panel',
          group = 'Number',
          action = 'Mason',
          key = '2',
        },
        {
          desc = ' Neovim Config',
          group = 'DiagnosticHint',
          action = function()
            local config_path = vim.fn.stdpath('config')
            local open_cwd_project = require('helper.project').open_cwd_project
            open_cwd_project(config_path)
            require('dashboard').setup(M.get_dashboard_config())
          end,
          key = '3',
        },
        {
          desc = ' LeetCode',
          group = 'WarningMsg',
          action = function()
            vim.cmd('Leet')
          end,
          key = '4',
        },
      },
      center = {},
      project = {
        enable = true,
        limit = 4,
        action = function(cwd)
          local open_cwd_project = require('helper.project').open_cwd_project
          open_cwd_project(cwd)
          require('dashboard').setup(M.get_dashboard_config())
        end,
      },
      mru = { enable = false },
      footer = {},
    },
  }
  return config
end

return M
