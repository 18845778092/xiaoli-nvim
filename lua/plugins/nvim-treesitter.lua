return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  enabled = true,
  config = function()
    require('nvim-treesitter.configs').setup({
      -- 启用语法高亮
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- 启用代码缩进
      indent = {
        enable = true,
      },
      -- 启用增量选择
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        },
      },
      -- 确保安装的语言解析器
      ensure_installed = {
        'bash',
        -- 'css',
        'html',
        'javascript',
        'json',
        'lua',
        'rust',
        'typescript',
        'vim',
        -- 'vue',
      },
    })
  end,
}
