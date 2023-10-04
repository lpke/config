--------------------------
-- TELESCOPE
--------------------------

--local builtin = require('telescope.builtin')

--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<C-p>', builtin.git_files, {})

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.3',
  dependencies = { 'nvim-lua/plenary.nvim' }
}
