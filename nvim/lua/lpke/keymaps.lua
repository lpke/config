local helpers = require('helpers')
local keymap_set = helpers.keymap_set
-- SETTER SYNTAX: {'<modes><N=noremap,!=silent>', <from>, <to>, {opts}}

-- remap leader to space
vim.g.mapleader = ' '

local keymaps = {
  -- window (pane) navigation
  {'n', '<C-h>', '<C-w>h'},
  {'n', '<C-j>', '<C-w>j'},
  {'n', '<C-k>', '<C-w>k'},
  {'n', '<C-l>', '<C-w>l'},

  -- tab navigation
  -- TODO

  -- horizontal mouse scrolling
  {'n', '<A-ScrollWheelDown>', '6zl'},
  {'n', '<A-ScrollWheelUp>', '6zh'},

  {'n', '<leader>pv', vim.cmd.Ex}, -- open netrw
  {'n', '<leader>L', '<cmd>Lazy<cr>'}, -- package manager
  {'nN!', '<C-w>w', ':set wrap!<CR>'}, -- toggle line wrap
}
helpers.keymap_set_multi(keymaps)

-- convert windows line endings to unix when pasting from global registers
if helpers.is_wsl then
  keymap_set({'nN!', '"*p', function() helpers.paste_unix('*') end})
  keymap_set({'nN!', '"+p', function() helpers.paste_unix('+') end})
end

