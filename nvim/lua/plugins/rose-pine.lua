local function config()
  -- TODO do this prime's way with ColorMyPencils
  vim.cmd('colorscheme rose-pine')
end

return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = config
}
