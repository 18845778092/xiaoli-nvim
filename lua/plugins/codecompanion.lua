return {
  'olimorris/codecompanion.nvim',
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'github/copilot.vim',
    'j-hui/fidget.nvim',
    'franco-ruggeri/codecompanion-spinner.nvim',
  },
  init = function()
    require('helper.codecompanion-fidget-spinner'):init()
  end,
  config = function()
    require('codecompanion').setup({
      extensions = {
        spinner = {},
      },
      strategies = {
        chat = {
          adapter = 'kimi',
        },
        inline = {
          adapter = 'kimi',
        },
        cmd = {
          adapter = 'kimi',
        },
      },
      adapters = {
        kimi = function()
          return require('codecompanion.adapters').extend('openai', {
            name = 'kimi',
            url = 'https://api.moonshot.cn/v1/chat/completions',
            env = {
              api_key = vim.fn.getenv('MOONSHOT_API_KEY'),
            },
            headers = {
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer ${api_key}',
            },
            parameters = {
              model = 'kimi-k2-0711-preview',
              temperature = 0.7,
              stream = true,
              max_tokens = 16384,
            },
            schema = {
              model = {
                order = 1,
                mapping = 'parameters',
                type = 'enum',
                desc = 'Kimi 模型选择',
                default = 'kimi-k2-0711-preview',
                choices = {
                  'kimi-k2-0711-preview',
                },
              },
              temperature = {
                order = 2,
                mapping = 'parameters',
                type = 'number',
                optional = true,
                default = 0.7,
                desc = '控制输出随机性',
                validate = function(n)
                  return n >= 0 and n <= 2
                end,
              },
            },
          })
        end,
      },
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('n', '<leader>pp', '<CMD>CodeCompanionChat Toggle<CR>')
      end,
    })
  end,
}
