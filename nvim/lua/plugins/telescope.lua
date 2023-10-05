local helpers = require('lpke.helpers')

local opts = {
  -- config options
}

local function config()
  require('telescope').setup(opts)
end

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.3',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config
}
