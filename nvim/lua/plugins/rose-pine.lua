--------------------------
-- ROSE-PINE (theme)
--------------------------

return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme rose-pine]]) -- TODO do this prime's way with ColorMyPencils
  end,
}
