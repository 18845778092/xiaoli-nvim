-- bottom status line

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    local status_ok, lualine = pcall(require, 'lualine')
    local color_table = require('core.custom-style').color_table

    if not status_ok then
      vim.notify('lualine not found!')
      return
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = true,
    }
    local progress = {
      'progress',
      color = { fg = '#ffffff' },
    }

    local mode = {
      'mode',
      fmt = function(str)
        return '-- ' .. str .. ' --'
      end,
      color = { fg = '#ffffff', gui = 'bold' },
    }

    local file_name = {
      'filename',
      file_status = true,
      path = 1, -- 0: Just the filename 1: Relative path 2: Absolute path
      color = { fg = color_table.light_green, gui = 'bold' },
      shorting_target = 40,
      symbols = {
        modified = '[+]',
        readonly = '[-]',
        unnamed = '[No Name]',
      },
      separator = { left = '', right = '' },
    }

    local tabline_file_name = {
      'filename',
      file_status = true, -- Displays file status (readonly status, modified status)
      path = 0, -- 0: Just the filename

      shorting_target = 40, -- Shortens path to leave 40 spaces in the window
      symbols = {
        modified = '[+]', -- Text to show when the file is modified.
        readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
      },
    }

    local filetype = {
      'filetype',
      icons_enabled = false,
      icon = nil,
    }

    local branch = {
      'branch',
      icons_enabled = true,
      icon = '',
    }

    local venn_indicator = {
      function()
        if vim.b.venn_enabled then
          return '🎨 Venn Mode'
        else
          return ''
        end
      end,
      color = { fg = '#ff6b6b', gui = 'bold' },
      cond = function()
        return vim.b.venn_enabled ~= nil
      end,
    }

    -- add gps module to get the position information
    -- local gps = require("nvim-gps")

    lualine.setup({
      options = {
        icons_enabled = true,
        -- theme = 'auto',
        -- theme = 'gruvbox_light',
        -- theme = 'molokai',
        theme = 'powerline_dark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { branch, diagnostics },
        lualine_b = { mode },
        lualine_c = { file_name, venn_indicator },
        lualine_x = { filetype, 'fileformat' },
        lualine_y = { progress },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { file_name },
        lualine_x = { 'location' },
      },
      -- tabline = {
      --   lualine_c = { tabline_file_name },
      --   lualine_z = { 'tabs' },
      -- },
      extensions = {},
    })
  end,
}
