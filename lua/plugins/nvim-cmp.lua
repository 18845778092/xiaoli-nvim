-- auto code completion

local symbol_map = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

return {
  'hrsh7th/nvim-cmp',
  event = { 'BufReadPre', 'BufNewFile', 'VimEnter' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- lsp auto-completion
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'hrsh7th/cmp-cmdline', -- cmdline auto-completion
    'saadparwaiz1/cmp_luasnip', -- for autocompletion
    'xzbdmw/colorful-menu.nvim',
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

    -- insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    local snippets_path = vim.fn.stdpath('config') .. '/snippets'
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

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()
    -- 加载自定义代码片段
    require('luasnip.loaders.from_vscode').lazy_load({ paths = snippets_path })
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
        debounce = 30,
      },
      completion = {
        keyword_length = 0,
        completeopt = 'menu,menuone,preview,select',
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-e>'] = cmp.mapping.abort(), -- close completion window
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            -- 默认 Tab 行为
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
          end
        end),

        ['<C-i>'] = cmp.mapping(function()
          -- vscode like complete by <C-i>
          if not cmp.visible() and has_words_before() then
            cmp.complete()
          end
        end), -- i - insert mode; s - select mode
        ['<C-y>'] = cmp.mapping(function(fallback)
          fallback()
        end),
      }, { 'i' }),
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

            local cursor_before_line = ctx.cursor_before_line
            -- For events
            if cursor_before_line:sub(-1) == '@' then
              return entry.completion_item.label:match('^@')
              -- For props also exclude events with `:on-` prefix
            elseif cursor_before_line:sub(-1) == ':' then
              -- entry.completion_item.label:match('^:')
              return entry.completion_item.label:match(':') and not entry.completion_item.label:match('^:on%-')
            elseif cursor_before_line:sub(-1) == '#' then
              return entry.completion_item.kind == types.lsp.CompletionItemKind.Method
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

      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local kind = require('lspkind').cmp_format({
            mode = 'symbol_text',
            symbol_map = symbol_map,
          })(entry, vim.deepcopy(vim_item))
          local highlights_info = require('colorful-menu').cmp_highlights(entry)

          if highlights_info ~= nil then
            vim_item.abbr_hl_group = highlights_info.highlights
            local strings = vim.split(highlights_info.text, '%s', { trimempty = true })
            vim_item.abbr = strings[1] or ''
          end

          local strings = vim.split(kind.kind, '%s', { trimempty = true })
          vim_item.kind = '' .. (strings[1] or '') .. ''
          vim_item.menu = '[' .. entry.source.name .. ']'

          return vim_item
        end,
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
    end, { 'c' })

    cmdline_mapping['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'c' })

    cmdline_mapping['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
      else
        fallback()
      end
    end, { 'c' })

    vim.schedule(function()
      cmdline_mapping['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { 'c' })
    end, 100)

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmdline_mapping,
      completion = {
        completeopt = 'menu,menuone,select',
      },
      sources = {
        { name = 'buffer', keyword_length = 0 },
      },
    })

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
      sorting = {
        comparators = {
          function(entry1, entry2)
            local input = vim.fn.getcmdline()
            local label1 = entry1.completion_item.label
            local label2 = entry2.completion_item.label

            -- :w -> write
            if input == 'w' then
              if label1 == 'write' and label2 ~= 'write' then
                return true
              elseif label2 == 'write' and label1 ~= 'write' then
                return false
              end

              if label1 == 'w' and label2 ~= 'w' then
                return true
              elseif label2 == 'w' and label1 ~= 'w' then
                return false
              end
            end

            -- q -> quit
            if input == 'q' then
              if label1 == 'quit' and label2 ~= 'quit' then
                return true
              elseif label2 == 'quit' and label1 ~= 'quit' then
                return false
              end

              if label1 == 'q' and label2 ~= 'q' then
                return true
              elseif label2 == 'q' and label1 ~= 'q' then
                return false
              end
            end

            return nil
          end,
        },
      },
    })

    cmp.event:on('menu_closed', function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.b[bufnr]._vue_ts_cached_is_in_start_tag = nil
    end)

    -- 代码片段 光标跳转顺序
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.keymap.set('i', '<Tab>', function()
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            -- 默认 Tab 行为
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
          end
        end, { noremap = true, silent = true })

        vim.keymap.set('i', '<S-Tab>', function()
          luasnip.jump(-1)
        end, { noremap = true, silent = true })
      end,
    })
  end,
}
