-- auto code completion

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

    -- check if in start tag
    local function is_in_start_tag()
      local ts_utils = require('nvim-treesitter.ts_utils')
      local node = ts_utils.get_node_at_cursor()
      if not node then
        return false
      end
      local node_to_check = { 'start_tag', 'self_closing_tag', 'directive_attribute' }
      return vim.tbl_contains(node_to_check, node:type())
    end
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
        max_view_entries = 30,
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
        {
          name = 'nvim_lsp',
          ---@param entry cmp.Entry
          ---@param ctx cmp.Context
          entry_filter = function(entry, ctx)
            -- Check if the buffer type is 'vue'
            if ctx.filetype ~= 'vue' then
              return true
            end

            -- Use a buffer-local variable to cache the result of the Treesitter check
            local bufnr = ctx.bufnr
            local cached_is_in_start_tag = vim.b[bufnr]._vue_ts_cached_is_in_start_tag
            if cached_is_in_start_tag == nil then
              vim.b[bufnr]._vue_ts_cached_is_in_start_tag = is_in_start_tag()
            end
            -- If not in start tag, return true
            if vim.b[bufnr]._vue_ts_cached_is_in_start_tag == false then
              return true
            end
            -- rest of the code

            local cursor_before_line = ctx.cursor_before_line
            -- For events
            if cursor_before_line:sub(-1) == '@' then
              return entry.completion_item.label:match('^@')
              -- For props also exclude events with `:on-` prefix
            elseif cursor_before_line:sub(-1) == ':' then
              return entry.completion_item.label:match('^:') and not entry.completion_item.label:match('^:on%-')
            else
              return true
            end
          end,
        },
        { name = 'luasnip' }, -- snippets
        { name = 'buffer' }, -- text within current buffer
        { name = 'path' }, -- file system paths
        { name = 'render-markdown' },
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = '...',
        }),
      },
    })

    local cmdline_mapping = cmp.mapping.preset.cmdline()

    -- 在补全菜单可见时使用 Up/Down 选择，否则回退到默认行为
    cmdline_mapping['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback() -- 使用默认的历史记录导航
      end
    end, { 'c' }) -- 'c' 命令行模式

    cmdline_mapping['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback() -- 使用默认的历史记录导航
      end
    end, { 'c' })

    cmp.setup.cmdline(':', {
      mapping = cmdline_mapping,
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
    vim.api.nvim_set_hl(0, 'Pmenu', {
      bg = '#252526', -- VSCode 深色背景
      fg = '#CCCCCC', -- 浅灰色文字
      blend = 0, -- 不透明
    })

    vim.api.nvim_set_hl(0, 'PmenuSel', {
      bg = '#094771', -- VSCode 蓝色选中背景
      fg = '#FFFFFF',
      bold = true,
    })

    vim.api.nvim_set_hl(0, 'PmenuSbar', {
      bg = '#3E3E42', -- 滚动条背景
    })

    vim.api.nvim_set_hl(0, 'PmenuThumb', {
      bg = '#6A6A6A', -- 滚动条滑块
    })

    -- 补全菜单边框
    vim.api.nvim_set_hl(0, 'FloatBorder', {
      fg = '#464647', -- 边框颜色
      bg = '#252526', -- 边框背景
    })

    -- 补全项类型图标颜色
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#D4D4D4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#B180D7' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#B180D7' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#B180D7' })
    vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#9CDCFE' })
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#9CDCFE' })
    vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#4EC9B0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#4EC9B0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#4EC9B0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#9CDCFE' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#4EC9B0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#569CD6' })
    vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#D7BA7D' })
    vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#D7BA7D' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#D7BA7D' })
    vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#D7BA7D' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#D7BA7D' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = '#4FC1FF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#4FC1FF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#4EC9B0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#4EC9B0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#D4D4D4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#4EC9B0' })

    cmp.event:on('menu_closed', function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.b[bufnr]._vue_ts_cached_is_in_start_tag = nil
    end)
  end,
}
