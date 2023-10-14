local function config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local builtin = require('telescope.builtin')
  local helpers = require('lpke.helpers')

  -- mappings to access telescope
  local keymaps = {
    {'nC', '<BS>/', 'Telescope find_files'},
    {'nC', '<BS>s', 'Telescope live_grep'},
    {'n', '<BS>S', function() builtin.grep_string({ search = vim.fn.input('Grep > ') }) end},
    {'nC', '<BS>f', 'Telescope git_files'},
    {'nC', '<leader>/', 'Telescope current_buffer_fuzzy_find'},
  }
  helpers.keymap_set_multi(keymaps)

  -- options
  telescope.setup({
    defaults = {
      path_display = {
        truncate = true,
      },
      mappings = {
        i = {
          ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
        },
        n = {
          ['u'] = { '<cmd>undo<cr>', type = 'command' },
          ['<Up>'] = function(bufnr) helpers.repeat_function(actions.move_selection_previous, bufnr, 4) end,
          ['<Down>'] = function(bufnr) helpers.repeat_function(actions.move_selection_next, bufnr, 4) end,
        },
      },
    },
    pickers = {
      find_files = {
        mappings = {
          -- ...
        },
      },
    },
  })

  -- extensions
  telescope.load_extension('session-lens')
  telescope.load_extension('fzf')
end

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- improves sorting performance (as per docs):
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = config
}
