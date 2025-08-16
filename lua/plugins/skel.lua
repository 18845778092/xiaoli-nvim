return {
  'motosir/skel-nvim',
  enabled = true,
  config = function()
    -- import basic default placeholder callbacks
    local skeld = require('skel-nvim.defaults')

    require('skel-nvim').setup({
      -- dir containing skeleton files (default)
      templates_dir = vim.fn.stdpath('config') .. '/skeletons',

      -- enable/disable plugin, this supercedes disable_for_empty_file (default)
      skel_enabled = true,

      -- enable/disable processing for bufread + empty file case (default)
      apply_skel_for_empty_file = true,

      -- file pattern -> template mappings (default)
      mappings = {
        ['*.vue'] = 'default.vue.skel',
        ['*.ts'] = 'default.ts.skel',
        ['*Control.ts'] = 'Control.ts.skel',
      },

      -- substitutions in templates (default)
      -- can be a string or a callback function
      -- these are the set of default placeholders provided by the plugin
      substitutions = {
        ['FILENAME'] = function(config)
          local filename = vim.fs.basename(config.filename)
          return vim.fn.fnamemodify(filename, ':r')
        end,
        ['NAME'] = skeld.get_author,
        ['DATE'] = skeld.get_date,
      },

      -- Misc global config available to substitution callback functions
      author = 'Xiaoli',
      namespace = {},
    })
  end,
}
