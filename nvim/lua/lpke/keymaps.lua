local helpers = require('lpke.helpers')
local custom_options = require('lpke.options')
local keymap_set = helpers.keymap_set
-- SYNTAX: {'<modes><R=rec,E=expr,C=:,!=sil>', <lhs>, <rhs>, {opts}}
-- TIP: to show how vim sees a key: `:<ctrl+k>` then type a key

-- use space as leader and <BS> as a secondary 'leader'
keymap_set({'n', ' ', ''})
keymap_set({'n', '<BS>', ''})
vim.g.mapleader = ' '

local keymaps = {
  {'n', '<BS>r', vim.cmd.Ex}, -- open netrw
  {'nviC', '<C-s>', 'w'}, -- save file
  {'nC', '<BS>L', 'Lazy'}, -- package manager
  {'nC!', '<A-w>', 'set wrap!'}, -- toggle line wrap
  {'n!', '<A-c>', function() helpers.toggle_whitespace_hl(custom_options.whitespace_hl) end}, -- toggle show whitespace
  {'nC', '<A-r>', 'set relativenumber!'}, -- toggle relative numbers

  {'nv', '<leader>y', '"*y'}, -- global yank
  {'nv', '<leader>d', '"_d'}, -- delete without copy
  {'nv', 'gg', 'gg0'}, -- gg goes to very start
  {'nv', 'G', 'G$'}, -- G goes to very end
  {'n', 'Y', 'y$'}, -- capital Y yanks to end of line instead of whole line
  {'n', 'J', 'mzJ`z'}, -- dont move cursor when joining lines
  {'n', 'Q', ''}, -- remove Q keybind (re-run last macro) - use `@@` instead

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
  -- TODO

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
}
helpers.keymap_set_multi(keymaps)

-- convert windows line endings to unix when pasting from global registers
if helpers.is_wsl then
  keymap_set({'nv!', '"*p', function() helpers.paste_unix('*') end})
  keymap_set({'nv!', '"+p', function() helpers.paste_unix('+') end})
end

-- disabling shortcuts of :read to prevent accidental activation when typing :reg
vim.cmd('cabbrev r echo "shorthand for :read disabled"')
vim.cmd('cabbrev re echo "shorthand for :read disabled"')
vim.cmd('cabbrev rea echo "shorthand for :read disabled"')
