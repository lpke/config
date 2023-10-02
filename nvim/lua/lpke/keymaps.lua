local helpers = require('lpke.helpers')
local keymap_set = helpers.keymap_set
-- SETTER SYNTAX: {'<modes><N=noremap,E=expr,!=silent>', <from>, <to>, {opts}}

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

  -- arrow-key scrolling
  {'nvN', '<Down>', '<C-e>'},
  {'nvN', '<Up>', '<C-y>'},
  {'nvN', '<S-Down>', '4<C-e>'},
  {'nvN', '<S-Up>', '4<C-y>'},
  {'nvN', '<Left>', '6zh'},
  {'nvN', '<Right>', '6zl'},

  -- horizontal mouse scrolling
  {'n', '<A-ScrollWheelDown>', '6zl'},
  {'n', '<A-ScrollWheelUp>', '6zh'},

  -- move selected code up/down
  {'v', 'J', ":m '>+1<CR>gv=gv"},
  {'v', 'K', ":m '<-2<CR>gv=gv"},

  -- wrapped line traversing
  {'nNE', 'j', 'v:count ? "j" : "gj"'},
  {'nNE', 'k', 'v:count ? "k" : "gk"'},

  {'n', 'J', 'mzJ`z'}, -- dont move cursor when joining lines
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

