return {
  'heavenshell/vim-jsdoc',
  config = function()
    local function get_lehre_path()
      local handle = io.popen('which lehre')

      if handle then
        local result = handle:read('*a'):gsub('\n.*$', '') -- 取第一个结果
        handle:close()
        return result ~= '' and result or nil
      end
      return nil
    end

    -- 设置 jsdoc_lehre_path
    vim.g.jsdoc_lehre_path = get_lehre_path()
  end,
}
