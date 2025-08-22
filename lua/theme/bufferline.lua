local color_table = require('core.custom-style').color_table

local function get_bufferline_hl_map(ops)
  local visibleFgColor = ops.visibleFgColor
  local visibleColor = ops.visibleColor
  local selectedBgColor = ops.selectedBgColor
  local indicatorColor = ops.indicatorColor
  local duplicateColor = ops.duplicateColor
  local pickFgColor = ops.pickFgColor
  local errorFgColor = ops.errorFgColor
  local warningFgColor = ops.warningFgColor
  local infoFgColor = ops.infoFgColor
  local hintFgColor = ops.hintFgColor
  local fgColor = ops.fgColor

  return {
    buffer = {},
    buffer_visible = {
      fg = visibleFgColor,
      bg = visibleColor,
    },
    buffer_selected = {
      bg = selectedBgColor,
      fg = fgColor,
      bold = true,
    },
    numbers = {},
    numbers_visible = {
      fg = visibleFgColor,
      bg = visibleColor,
    },
    numbers_selected = {
      bg = selectedBgColor,
      fg = fgColor,
    },
    separator = {},
    separator_visible = {
      bg = visibleColor,
    },
    separator_selected = {
      bg = selectedBgColor,
      bold = true,
    },
    duplicate = {},
    duplicate_visible = {
      fg = duplicateColor,
      bg = visibleColor,
    },
    duplicate_selected = {
      fg = duplicateColor,
      bg = selectedBgColor,
      bold = true,
    },
    modified = {
      fg = indicatorColor,
    },
    modified_visible = {
      fg = indicatorColor,
      bg = visibleColor,
    },
    modified_selected = {
      fg = indicatorColor,
      bg = selectedBgColor,
      -- No need for bold!
    },
    error = {
      fg = errorFgColor,
    },
    warning = {
      fg = warningFgColor,
    },
    info = {
      fg = infoFgColor,
    },
    hint = {
      fg = hintFgColor,
    },
    error_selected = {
      fg = errorFgColor,
      bg = selectedBgColor,
      bold = true,
    },
    warning_selected = {
      fg = warningFgColor,
      bg = selectedBgColor,
      bold = true,
    },
    info_selected = {
      fg = infoFgColor,
      bg = selectedBgColor,
      bold = true,
    },
    hint_selected = {
      fg = hintFgColor,
      bg = selectedBgColor,
      bold = true,
    },
    error_visible = {
      fg = errorFgColor,
      bg = visibleColor,
    },
    warning_visible = {
      fg = warningFgColor,
      bg = visibleColor,
    },
    info_visible = {
      fg = infoFgColor,
      bg = visibleColor,
    },
    hint_visible = {
      fg = hintFgColor,
      bg = visibleColor,
    },
    error_diagnostic = {
      fg = errorFgColor,
    },
    warning_diagnostic = {
      fg = warningFgColor,
    },
    info_diagnostic = {
      fg = infoFgColor,
    },
    hint_diagnostic = {
      fg = hintFgColor,
    },
    error_diagnostic_selected = {
      fg = errorFgColor,
      bg = selectedBgColor,
      bold = true,
    },
    warning_diagnostic_selected = {
      fg = warningFgColor,
      bg = selectedBgColor,
      bold = true,
    },
    info_diagnostic_selected = {
      fg = infoFgColor,
      bg = selectedBgColor,
      bold = true,
    },
    hint_diagnostic_selected = {
      fg = hintFgColor,
      bg = selectedBgColor,
      bold = true,
    },
    error_diagnostic_visible = {
      fg = errorFgColor,
      bg = visibleColor,
    },
    warning_diagnostic_visible = {
      fg = warningFgColor,
      bg = visibleColor,
    },
    info_diagnostic_visible = {
      fg = infoFgColor,
      bg = visibleColor,
    },
    hint_diagnostic_visible = {
      fg = hintFgColor,
      bg = visibleColor,
    },
    pick = {
      fg = pickFgColor,
    },
    pick_selected = {
      fg = pickFgColor,
      bg = selectedBgColor,
      bold = true,
    },
    pick_visible = {
      fg = pickFgColor,
      bg = visibleColor,
    },
  }
end

local darkplus_hl_map = get_bufferline_hl_map({
  selectedBgColor = '#4792a8',
  fgColor = '#ffffff',
  visibleColor = color_table.current_index,
  indicatorColor = '#fde047',
  duplicateColor = color_table.light_green,
  pickFgColor = color_table.light_green,
  visibleFgColor = '#e2e8f0',
  errorFgColor = '#ffffff',
  warningFgColor = '#ffffff',
  infoFgColor = '#ffffff',
  hintFgColor = '#ffffff',
})

local M = {}

function M.get_bufferline_config()
  return {
    options = {
      numbers = function(opts)
        return string.format('%s ╱', opts.ordinal)
      end,
      max_prefix_length = 25,
      max_name_length = 40, -- 文件名最大长度
      diagnostics = 'nvim_lsp',
      offsets = {
        -- {
        --   filetype = 'NvimTree',
        --   text = function()
        --     return 'File Explorer -> ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        --   end,
        --   highlight = 'Directory',
        --   text_align = 'center',
        -- },
      },
      -- 插入顺序排序
      sort_by = 'insert_at_end',
      show_buffer_close_icons = false,
      separator_style = 'slope', -- slant , slope
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icons = {
          error = ' ',
          warning = ' ',
          info = ' ',
          hint = '󰚩 ',
        }
        local result = {}
        for severity, count in pairs(diagnostics_dict) do
          if count > 0 then
            table.insert(result, icons[severity] .. count)
          end
        end

        return table.concat(result, ' ')
      end,
    },
    highlights = darkplus_hl_map,
  }
end

M.highlight_map = {
  darkplus = darkplus_hl_map,
  ['gruvbox-material'] = get_bufferline_hl_map({
    selectedBgColor = color_table.gruvbox_material_background,
    fgColor = '#ffffff',
    visibleColor = color_table.current_index,
    indicatorColor = '#fde047',
    duplicateColor = '#ffffff',
    pickFgColor = color_table.light_green,
    visibleFgColor = '#e2e8f0',
    errorFgColor = '#ffffff',
    warningFgColor = '#ffffff',
    infoFgColor = '#ffffff',
    hintFgColor = '#ffffff',
  }),
  default = darkplus_hl_map,
}

function M.get_relative_hl()
  local current_colorscheme = vim.g.colors_name
  return M.highlight_map[current_colorscheme] or M.highlight_map.default
end

return M
