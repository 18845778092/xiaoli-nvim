-- terminal

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    build = 'brew install lazygit',
    config = function()
      require('toggleterm').setup({
        highlights = {
          FloatBorder = {
            guifg = '#72c6b1',
          },
        },
        direction = 'float',
        float_opts = {
          border = 'double',
        },
      })

      local Terminal = require('toggleterm.terminal').Terminal

      -- 普通终端
      local normal_term = Terminal:new({
        count = 1, -- 唯一 ID
        float_opts = {
          winblend = 20, -- 透明度 (0-100)
        },
      })

      -- Lazygit 终端
      local lazygit = Terminal:new({
        cmd = 'lazygit',
        dir = 'git_dir',
        count = 2, -- 唯一 ID
        float_opts = {
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
          -- 进程退出时自动关闭终端窗口
          vim.schedule(function()
            if term:is_open() then
              term:close()
            end
          end)
        end,
      })

      function _NORMAL_TERM_TOGGLE()
        normal_term:toggle()
      end

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      -- 预创建终端
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          vim.keymap.set({ 'n', 't' }, '<C-t>', '<cmd>lua _NORMAL_TERM_TOGGLE()<CR>', {
            noremap = true,
            silent = true,
            desc = '切换普通终端',
          })

          vim.keymap.set({ 'n', 't' }, '<C-g>', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', {
            noremap = true,
            silent = true,
            desc = '切换 Lazygit',
          })

          vim.schedule(function()
            normal_term:spawn()
          end)
        end,
      })
    end,
  },
}
