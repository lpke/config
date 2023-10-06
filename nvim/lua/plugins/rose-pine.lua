local function config()
  -- TODO do this prime's way with ColorMyPencils
  vim.cmd('colorscheme rose-pine')

  -- remove end of buffer characters '~' in line column
  require('lpke.helpers').set_hl('EndOfBuffer', { fg = 'bg' })
end

return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = config
}
