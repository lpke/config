local function config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local builtin = require('telescope.builtin')
  local helpers = require('lpke.helpers')

  local function find_git_files() if helpers.cwd_has_git() then builtin.git_files() else builtin.find_files() end end
  local function grep_yanked() builtin.grep_string({ search = vim.fn.getreg('"') }) end
  local function grep_custom() builtin.grep_string({ search = vim.fn.input('Grep > ') }) end

  -- mappings to access telescope
  local keymaps = {
    {'nC', '<BS><BS>', 'Telescope find_files', { desc = 'Fuzzy find files in cwd' }},
    {'n', '<BS>ff', find_git_files, { desc = 'Fuzzy find git files in cwd (or cwd if not git)' }},
    {'nC', '<BS>/', 'Telescope live_grep', { desc = 'Find string in cwd' }},
    {'nC', '<leader>/', 'Telescope current_buffer_fuzzy_find', { desc = 'Fuzzy find in current file' }},
    {'n', '<BS>fp', grep_yanked, { desc = 'Find pasted string in cwd' }},
    {'n', '<BS>fi', grep_custom, { desc = 'Find input string in cwd' }},
    {'nC', '<BS>fw', 'Telescope grep_string', { desc = 'Find string under cursor in cwd' }},
    {'nC', '<BS><leader>', 'Telescope resume', { desc = 'Resume previous Telescope search' }},
    {'nC', '<BS>fr', 'Telescope oldfiles', { desc = 'Fuzzy find recent files' }},
    {'nC', "<BS>fj", 'Telescope jumplist', { desc = 'Fuzzy find jumplist' }},
    {'nC', "<BS>fb", 'Telescope buffers', { desc = 'Fuzzy find buffers' }},
    {'nC', "<BS>f'", 'Telescope registers', { desc = 'Fuzzy find registers' }},
    {'nC', "<BS>fm", 'Telescope marks', { desc = 'Fuzzy find marks' }},
    {'nC', "<BS>fh", 'Telescope help_tags', { desc = 'Fuzzy find help tags' }},
    {'nC', "<BS>ft", 'Telescope treesitter', { desc = 'Fuzzy find treesitter symbols' }},
    {'nC', "<BS>fgc", 'Telescope git_commits', { desc = 'Fuzzy find git commits' }},
    {'nC', "<BS>fgf", 'Telescope git_bcommits', { desc = 'Fuzzy find buffer git commits' }},
    {'nC', "<BS>fgb", 'Telescope git_branches', { desc = 'Fuzzy find git branches' }},
    {'nC', "<BS>fgs", 'Telescope git_status', { desc = 'Fuzzy find git status' }},
    {'nC', "<BS>fgz", 'Telescope git_stash', { desc = 'Fuzzy find git stash' }},
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
          ['<C-j>'] = actions.preview_scrolling_down,
          ['<C-k>'] = actions.preview_scrolling_up,
          -- ['<C-h>'] = actions.preview_scrolling_left,
          -- ['<C-l>'] = actions.preview_scrolling_right,
        },
        n = {
          ['u'] = { '<cmd>undo<cr>', type = 'command' },
          ['<Up>'] = function(bufnr) helpers.repeat_function(actions.move_selection_previous, bufnr, 4) end,
          ['<Down>'] = function(bufnr) helpers.repeat_function(actions.move_selection_next, bufnr, 4) end,
          ['<C-j>'] = actions.preview_scrolling_down,
          ['<C-k>'] = actions.preview_scrolling_up,
          -- ['<C-h>'] = actions.preview_scrolling_left,
          -- ['<C-l>'] = actions.preview_scrolling_right,
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
