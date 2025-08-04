return function()
  -- Lua
  require('plugins.lsp.servers.lua')()

  -- Vue
  require('plugins.lsp.servers.vue')()

  -- ESLint
  require('plugins.lsp.servers.eslint')()

  -- Biome
  -- require('plugins.lsp.servers.biome')()

  -- Css
  require('plugins.lsp.servers.css')()
end
