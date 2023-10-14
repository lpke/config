local function config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local builtin = require('telescope.builtin')

  -- mappings to access telescope
  local keymaps = {
    {'nC', '<BS>/', 'Telescope find_files'},
    {'nC', '<BS>s', 'Telescope live_grep'},
    {'n', '<BS>S', function() builtin.grep_string({ search = vim.fn.input('Grep > ') }) end},
    {'nC', '<BS>f', 'Telescope git_files'},
    {'nC', '<leader>/', 'Telescope current_buffer_fuzzy_find'},
  }
  require('lpke.helpers').keymap_set_multi(keymaps)

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
          ['K'] = actions.move_selection_previous, -- TODO: fast scrolling
          ['J'] = actions.move_selection_next,
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
