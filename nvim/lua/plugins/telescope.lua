local keymaps = {
  {'nC', '<BS>/', 'Telescope find_files'},
  {'nC', '<BS>s', 'Telescope live_grep'},
  {'nC', '<BS>f', 'Telescope git_files'},
}

local opts = {
  -- config options
}

local function config()
  require('telescope').setup(opts)
  require('lpke.helpers').keymap_set_multi(keymaps)
end

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.3',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config
}
