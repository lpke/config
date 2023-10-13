local helpers = require('lpke.helpers')
local options = require('lpke.options')
local keymap_set = helpers.keymap_set
-- SYNTAX: {'<modes><R=rec,E=expr,C=:,!=sil,D=delete>', <lhs>, <rhs>, {opts}}
-- TIP: to show how vim sees a key: `:<ctrl+k>` then type a key

-- use space as leader and <BS> as a secondary 'leader'
keymap_set({'n', ' ', ''})
keymap_set({'n', '<BS>', ''})
vim.g.mapleader = ' '

local keymaps = {
  {'n', '<BS>e', vim.cmd.Ex}, -- open netrw
  -- {'n', '<BS>r', ''}, -- TODO open ranger/tele-fb?
  {'nviC', '<C-s>', 'w'}, -- save file
  {'nC', '<BS>L', 'Lazy'}, -- package manager
  {'nC', '<BS>I', 'Inspect'}, -- inspect under cursor
  {'nC!', '<A-w>', 'set wrap!'}, -- toggle line wrap
  {'n!', '<A-c>', function() helpers.toggle_whitespace_hl(options.custom_opts.whitespace_hl) end}, -- toggle show whitespace
  {'nC', '<A-r>', 'set relativenumber!'}, -- toggle relative numbers
  {'n', '<A-s>', function() helpers.toggle_global_status() end}, -- toggle global status line

  {'nv', '<leader>y', '"*y'}, -- global yank
  {'nv', '<leader>d', '"_d'}, -- delete without copy
  {'nv', 'gg', 'gg0'}, -- gg goes to very start
  {'nv', 'G', 'G$'}, -- G goes to very end
  {'n', 'Y', 'y$'}, -- capital Y yanks to end of line instead of whole line
  {'n', 'J', 'mzJ`z'}, -- dont move cursor when joining lines
  {'n', 'Q', ''}, -- remove Q keybind (re-run last macro) - use `@@` instead
  {'n', '=*', 'mzgg=G`zzz'}, -- indent whole file

  -- buffer navigation
  {'nvC', '<A-Down>', 'bnext'},
  {'nvC', '<A-Up>', 'bprev'},
  {'nvC', '<A-BS>', 'bdelete'},

  -- window control
  -- creation / deletion
  {'nvC', '<C-w>|', 'vsplit'},
  {'nvC', '<C-w>_', 'split'},
  -- TODO: Make more useful/flexible
  -- {'nvC', '<C-w>!|', 'topleft vsplit'},
  -- {'nvC', '<C-w>!_', 'topleft split'},
  {'n', '<C-w>x', '<C-w>c'},
  {'nC', 'QQ', 'q'},
  {'nC', '<C-w>QQ', 'qa'},
  {'nC', '<C-w>ZZ', 'wqa'},
  -- navigation
  {'nv', '<A-h>', '<C-w>h'},
  {'nv', '<A-j>', '<C-w>j'},
  {'nv', '<A-k>', '<C-w>k'},
  {'nv', '<A-l>', '<C-w>l'},
  {'i', '<A-h>', '<Esc>l<C-w>h'},
  {'i', '<A-j>', '<Esc>l<C-w>j'},
  {'i', '<A-k>', '<Esc>l<C-w>k'},
  {'i', '<A-l>', '<Esc>l<C-w>l'},
  -- resizing
  {'nv', '<C-Up>', '<C-w>+<C-w>+<C-w>+'},
  {'nv', '<C-Down>', '<C-w>-<C-w>-<C-w>-'},
  {'nv', '<C-Left>', '<C-w><<C-w><<C-w><'},
  {'nv', '<C-Right>', '<C-w>><C-w>><C-w>>'},
  -- zooming
  {'nC', '<C-w>C', 'tab split'},
  {'n', '<C-w>z', '<C-w>|<C-w>_'},

  -- tab control
  -- creation / deletion
  {'nC', '<C-w>c', 'tabnew'},
  {'nC', '<C-w>&', 'tabclose'},
  -- navigating
  {'nv', '<C-w><Right>', 'gt'},
  {'nv', '<C-w><Left>', 'gT'},
  {'nv', '<A-Right>', 'gt'},
  {'nv', '<A-Left>', 'gT'},

  -- arrow-key scrolling
  {'nv', '<Down>', '4<C-e>'},
  {'nv', '<Up>', '4<C-y>'},
  {'nv', '<S-Down>', '6zl'},
  {'nv', '<S-Up>', '6zh'},

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

  -- include char under cursor when d/c/y backwards
  {'n', 'db', 'vbd'},
  {'n', 'cb', 'vbc'},
  {'n', 'yb', 'vby'},
  {'n', 'dB', 'vBd'},
  {'n', 'cB', 'vBc'},
  {'n', 'yB', 'vBy'},
  {'n', 'd^', 'v^d'},
  {'n', 'c^', 'v^c'},
  {'n', 'y^', 'v^y'},
  {'n', 'd0', 'v0d'},
  {'n', 'c0', 'v0c'},
  {'n', 'y0', 'v0y'},

  -- dont include surrounding whitespace in a'|a"|a` motions
  {'v', [[a']], [[2i']]},
  {'v', [[a"]], [[2i"]]},
  {'v', [[a`]], [[2i`]]},
  {'n', [[da']], [[d2i']]},
  {'n', [[da"]], [[d2i"]]},
  {'n', [[da`]], [[d2i`]]},
  {'n', [[ca']], [[c2i']]},
  {'n', [[ca"]], [[c2i"]]},
  {'n', [[ca`]], [[c2i`]]},
  {'n', [[ya']], [[y2i']]},
  {'n', [[ya"]], [[y2i"]]},
  {'n', [[ya`]], [[y2i`]]},

  -- find and replace
  {'nv', 'S', ''}, -- clear default S functionality
  {'n', 'SS', ":s/"}, -- replace in current line
  {'n', 'SF', ":%s/"}, -- replace in current file
  {'n', 'SV', [[:'<,'>s/\%V]]}, -- replace in prev selection
  {'v', 'SV', [[:s/\%V]]}, -- replace in current selection
  {'n', 'S**', [[:%s/\<<c-r><c-w>\>/<c-r><c-w>/gi<left><left><left>]]}, -- replace under cursor (whole file)
  {'n', 'S*v', [[:'<,'>s/\%V\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]}, -- replace under cursor (prev selection)
  {'n', 'S*V', [[:'<,'>s/\%V\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]}, -- replace under cursor (prev selection)
}
helpers.keymap_set_multi(keymaps)

-- yank still: prevent cursor movement after yanking
helpers.keymap_set_yank_still_upwards(100)
helpers.keymap_set_yank_still_marks()

-- convert windows line endings to unix when pasting from global registers
if helpers.is_wsl then
  keymap_set({'nv!', '"*p', function() helpers.paste_unix('*') end})
  keymap_set({'nv!', '"+p', function() helpers.paste_unix('+') end})
end

-- disabling shortcuts of :read to prevent accidental activation when typing :reg
vim.cmd('cabbrev r echo "shorthand for :read disabled"')
vim.cmd('cabbrev re echo "shorthand for :read disabled"')
vim.cmd('cabbrev rea echo "shorthand for :read disabled"')

