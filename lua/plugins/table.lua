-- markdown tabel auto formatter

return {
  'SCJangra/table-nvim',
  ft = 'markdown',
  opts = {
    padd_column_separators = true, -- Insert a space around column separators.
    mappings = { -- next and prev work in Normal and Insert mode. All other mappings work in Normal mode.
      next = '<TAB>', -- Go to next cell.
      prev = '<S-TAB>', -- Go to previous cell.
      insert_row_up = '<leader>iu', -- Insert a row above the current row.
      insert_row_down = '<leader>id', -- Insert a row below the current row.
      move_row_up = '<A-S-k>', -- Move the current row up.
      move_row_down = '<A-S-j>', -- Move the current row down.
      insert_column_left = '<leader>il', -- Insert a column to the left of current column.
      insert_column_right = '<leader>ir', -- Insert a column to the right of current column.
      move_column_left = '<A-S-h>', -- Move the current column to the left.
      move_column_right = '<A-S-l>', -- Move the current column to the right.
      insert_table = '<leader>it', -- Insert a new table.
      insert_table_alt = '<A-S-t>', -- Insert a new table that is not surrounded by pipes.
      delete_column = '<ldeader>dl', -- Delete the column under cursor.
    },
  },
}
