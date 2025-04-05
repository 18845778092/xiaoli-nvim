return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    modes = {
      char = {
        enabled = false,
      },
    },
    -- 添加颜色覆盖配置
    highlight = {
      matches = true,             -- 启用匹配高亮
      groups = {
        match = "FlashMatch",     -- 匹配项样式
        current = "FlashCurrent", -- 当前项样式
        backdrop = "FlashBackdrop",
      }
    },
  },
  -- stylua: ignore
  keys = {
    { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
