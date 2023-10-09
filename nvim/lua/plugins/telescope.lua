local function config()
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
  require('telescope').setup({
    defaults = {
      mappings = {
        n = {
          ['u'] = { '<cmd>undo<cr>', type = 'command' },
        }
      }
    },
    pickers = {
      find_files = {
        mappings = {
          -- ...
        }
      },
    }
  })

  -- extensions
  require('telescope').load_extension 'session-lens'
end

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.3',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config
}
