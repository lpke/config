require('lpke.keymaps')
require('lpke.options')
local lazy_options = require('lpke.lazy_options')

-- lazy setup (package manager)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins: auto sourced from ./lua/plugins/*
-- options: imported from ./lua/lpke/lazy_options.lua
require('lazy').setup('plugins', lazy_options)

