-- auto code completion

local use_coc = false
-- 结合coc使用的配置
return {
  'hrsh7th/nvim-cmp',
  event = { 'BufReadPre', 'BufNewFile', 'VimEnter' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- lsp auto-completion
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'hrsh7th/cmp-cmdline', -- cmdline auto-completion
    'saadparwaiz1/cmp_luasnip', -- for autocompletion
    {
      'L3MON4D3/LuaSnip',
      -- follow latest release.
      version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = 'make install_jsregexp',
    },
    'rafamadriz/friendly-snippets', -- useful snippets
    'onsails/lspkind.nvim', -- vs-code like pictograms
  },
  config = function()
    local cmp = require('cmp')

    if use_coc then
      cmp.setup({
        performance = {
          max_view_entries = 30,
        },
        completion = {
          completeopt = 'menu,menuone,preview,noselect',
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    else
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require('luasnip.loaders.from_vscode').lazy_load()

      -- extend filetypes
      luasnip.filetype_extend('typescript', { 'javascript' })
      luasnip.filetype_extend('typescriptreact', { 'javascript' })
      luasnip.filetype_extend('javascriptreact', { 'javascript' })

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      cmp.setup({
        performance = {
          max_view_entries = 20,
        },
        completion = {
          completeopt = 'menu,menuone,preview,noselect',
          j,
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
          ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
          ['<C-e>'] = cmp.mapping.abort(), -- close completion window
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<TAB>'] = cmp.mapping.confirm({ select = false }),
          ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }), -- i - insert mode; s - select mode
          ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- snippets
          { name = 'buffer' }, -- text within current buffer
          { name = 'path' }, -- file system paths
        }),

        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = '...',
          }),
        },
      })
    end
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },
      }),
    })

    -- vim.api.nvim_set_hl(0, 'Pmenu', { ctermbg = 8, bg = '#3B4252' }) -- 常规项背景
    vim.api.nvim_set_hl(0, 'PmenuSel', { fg = '#0bf432', bg = '#3B4252' }) -- 选中项背景
  end,
}
