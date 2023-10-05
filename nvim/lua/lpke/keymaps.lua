local helpers = require('lpke.helpers')
local keymap_set = helpers.keymap_set
-- SETTER SYNTAX: {'<modes><R=recursive,E=expr,!=silent>', <from>, <to>, {opts}}

-- remap leader to space
keymap_set({'n', ' ', ''})
vim.g.mapleader = ' '

local keymaps = {
  -- window (pane) navigation
  {'nv', '<C-h>', '<C-w>h'},
  {'nv', '<C-j>', '<C-w>j'},
  {'nv', '<C-k>', '<C-w>k'},
  {'nv', '<C-l>', '<C-w>l'},
  {'i', '<C-h>', '<Esc><C-w>h'},
  {'i', '<C-j>', '<Esc><C-w>j'},
  {'i', '<C-k>', '<Esc><C-w>k'},
  {'i', '<C-l>', '<Esc><C-w>l'},

  -- tab navigation

  -- arrow-key scrolling
  {'nv', '<Down>', '4<C-e>'},
  {'nv', '<Up>', '4<C-y>'},
  {'nv', '<S-Down>', '<C-e>'},
  {'nv', '<S-Up>', '<C-y>'},
  {'nv', '<Left>', '6zh'},
  {'nv', '<Right>', '6zl'},

  -- center cursor when down/up page
  {'n', '<C-d>', '<C-d>zz'},
  {'n', '<C-u>', '<C-u>zz'},

  -- center cursor when searching
  {'n', 'n', 'nzzzv'},
  {'n', 'N', 'Nzzzv'},

  -- horizontal mouse scrolling
  {'n', '<A-ScrollWheelDown>', '6zl'},
  {'n', '<A-ScrollWheelUp>', '6zh'},

  -- move selected code up/down
  {'v', 'J', ":m '>+1<CR>gv=gv"},
  {'v', 'K', ":m '<-2<CR>gv=gv"},

  -- wrapped line traversing
  {'nE', 'j', 'v:count ? "j" : "gj"'},
  {'nE', 'k', 'v:count ? "k" : "gk"'},

  -- keep current reg when pasting over selected text
  {'v', 'p', 'P'}, 
  {'v', 'P', 'p'},

  -- repeatable multiline indentation
  {'v', '<', '<gv'},
  {'v', '>', '>gv'},

  -- include char under cursor when deleting/changing backwards
  {'n', 'db', 'vbd'},
  {'n', 'cb', 'vbc'},
  {'n', 'd^', 'v^d'},
  {'n', 'c^', 'v^c'},

  -- replace all occurences of word under cursor
  {'n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]},

  {'nv', 'gg', 'gg0'}, -- gg goes to very start
  {'nv', 'G', 'G$'}, -- G goes to very end
  {'nv', '<leader>d', '"_d'}, -- <leader>d for delete without copy
  {'nv', '<leader>y', '"*y'}, -- <leader>y for global yank
  {'n', 'Y', 'y$'}, -- capital Y yanks to end of line instead of whole line
  {'n', 'J', 'mzJ`z'}, -- dont move cursor when joining lines
  {'n', '<leader>pv', vim.cmd.Ex}, -- open netrw
  {'n', '<leader>L', '<cmd>Lazy<cr>'}, -- package manager
  {'n!', '<C-w>w', ':set wrap!<CR>'}, -- toggle line wrap
}
helpers.keymap_set_multi(keymaps)

-- convert windows line endings to unix when pasting from global registers
if helpers.is_wsl then
  keymap_set({'n!', '"*p', function() helpers.paste_unix('*') end})
  keymap_set({'n!', '"+p', function() helpers.paste_unix('+') end})
end

-- disabling shortcuts of :read to prevent accidental activation when typing :reg
vim.cmd('cabbrev r echo "shorthand for :read disabled"')
vim.cmd('cabbrev re echo "shorthand for :read disabled"')
vim.cmd('cabbrev rea echo "shorthand for :read disabled"')
