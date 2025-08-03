return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
  },
  event = 'VeryLazy',
  config = function()
    local config_path = vim.fn.stdpath('config')

    require('nvim-dap-virtual-text').setup()
    local dap, dapui = require('dap'), require('dapui')
    dapui.setup({
      controls = {
        element = 'repl',
        enabled = true,
        icons = {
          disconnect = '',
          pause = '',
          play = '',
          run_last = '',
          step_back = '',
          step_into = '',
          step_out = '',
          step_over = '',
          terminate = '',
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = '>',
        current_frame = '>',
        expanded = '',
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25,
            },
            {
              id = 'breakpoints',
              size = 0.25,
            },
            {
              id = 'stacks',
              size = 0.25,
            },
            {
              id = 'watches',
              size = 0.25,
            },
          },
          position = 'left',
          size = 60,
        },
        {
          elements = {
            {
              id = 'repl',
              size = 0.5,
            },
            {
              id = 'console',
              size = 0.5,
            },
          },
          position = 'bottom',
          size = 15,
        },
      },
      mappings = {
        edit = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        repl = 'r',
        toggle = 't',
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    })
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        -- 💀 Make sure to update this path to point to your installation
        args = { config_path .. '/js-debug/src/dapDebugServer.js', '${port}' },
      },
    }
    dap.configurations.javascript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', '<leader>4', function()
      dap.continue() -- 跳到下一个断点
    end, { noremap = true })
    vim.keymap.set('n', '<leader>1', function()
      dap.step_over()
    end, { noremap = true })
    vim.keymap.set('n', '<leader>2', function()
      dap.step_into()
    end, { noremap = true })
    vim.keymap.set('n', '<leader>3', function()
      dap.step_out()
    end, { noremap = true })
    vim.keymap.set('n', '<leader>b', function()
      dap.toggle_breakpoint()
    end, { noremap = true })
    vim.keymap.set('n', '<leader>t', function() -- 停止调试
      dap.terminate()
    end, { noremap = true })
    vim.keymap.set('n', '<leader>r', function() -- 重启调试
      dap.terminate()
      -- 使用run_last()复用上次配置重启调试
      dap.run_last()
    end, { noremap = true })
    vim.keymap.set('n', '<leader>f', function() -- 重启当前帧
      dap.restart_frame()
    end, { noremap = true })

    vim.keymap.set('n', '<leader>lp', function()
      dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end, { noremap = true })
    vim.keymap.set('n', '<leader>dr', function()
      dap.repl.open()
    end, { noremap = true })

    vim.api.nvim_create_user_command('Debug', function()
      vim.cmd('DapNew')
    end, { desc = 'Dapnew alias' })
  end,
}
