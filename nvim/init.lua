require("lpke.keymaps")
require("lpke.options")

--------------------------
-- LAZY SETUP
--------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme rose-pine]]) -- TODO do this prime's way with ColorMyPencils
    end,
  }
}

local options = {
	ui = {
		border = "single"
	}
}

require("lazy").setup(plugins, options)

--------------------------
-- MISC OPTIONS
--------------------------
vim.g.clipboard = {
  name = 'WslClipboard',
  copy = {
    ['+'] = 'clip.exe',
    ['*'] = 'clip.exe',
  },
  paste = {
    ['+'] = 'powershell.exe Get-Clipboard',
    ['*'] = 'powershell.exe Get-Clipboard',
  },
  cache_enabled = 1,
}

-- netrw
vim.g.netrw_banner = 0

-- disable next line auto-comment
 vim.cmd([[autocmd FileType * set formatoptions-=ro]])

