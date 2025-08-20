local color_table = require('core.custom-style').color_table

local M = {}

M.theme_map = {
  darkplus = 'powerline_dark',
  ['gruvbox-material'] = 'gruvbox-material',
  default = 'powerline_dark',
}

M.filename_map = {
  default = color_table.light_green,
  ['gruvbox-material'] = color_table.gruvbox_material_background,
}

local function get_filename_color()
  local current_colorscheme = vim.g.colors_name
  return M.filename_map[current_colorscheme] or M.filename_map.default
end

function M.get_lualine_config()
  local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    sections = { 'error', 'warn' },
    symbols = { error = ' ', warn = ' ' },
    colored = false,
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
  local file_name_color = get_filename_color()
  local file_name = {
    'filename',
    file_status = true,
    path = 1, -- 0: Just the filename 1: Relative path 2: Absolute path
    color = { fg = file_name_color, gui = 'bold' },
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

  local formatter = {
    function()
      -- Check if 'conform' is available
      local status, conform = pcall(require, 'conform')
      if not status then
        return 'Conform not installed'
      end

      local lsp_format = require('conform.lsp_format')

      -- Get formatters for the current buffer
      local formatters = conform.list_formatters_for_buffer()
      if formatters and #formatters > 0 then
        local formatterNames = {}

        for _, formatter in ipairs(formatters) do
          table.insert(formatterNames, formatter)
        end

        return '󰷈 ' .. table.concat(formatterNames, ' ')
      end

      -- Check if there's an LSP formatter
      local bufnr = vim.api.nvim_get_current_buf()
      local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

      if not vim.tbl_isempty(lsp_clients) then
        return '󰷈 LSP Formatter'
      end

      return ''
    end,
  }

  return {
    options = {
      icons_enabled = true,
      theme = M.get_lualine_theme(),
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { branch, diagnostics },
      lualine_b = { mode },
      lualine_c = { file_name, venn_indicator, formatter },
      lualine_x = { filetype, 'fileformat' },
      lualine_y = { progress },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { file_name },
      lualine_x = { 'location' },
    },
    extensions = {},
  }
end

function M.get_lualine_theme()
  local current_colorscheme = vim.g.colors_name
  return M.theme_map[current_colorscheme] or M.highlight_map.default
end

return M
