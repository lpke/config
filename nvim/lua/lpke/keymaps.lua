local helpers = require('lpke.helpers')
local options = require('lpke.options')
local keymap_set = helpers.keymap_set
-- SYNTAX: {'<modes><R=rec,E=expr,C=:,!=sil,D=delete>', <lhs>, <rhs>, <desc>, {opts}}
-- TIP: to show how vim sees a key: `:<ctrl+k>` then type a key

-- use space as leader and <BS> as a secondary 'leader'
keymap_set({'n', ' ', ''})
keymap_set({'n', '<BS>', ''})
vim.g.mapleader = ' '

local keymaps = {
  -- {'n', '<BS>r', ''}, -- TODO open ranger/tele-fb?
  {'n', '<BS>e', vim.cmd.Ex, { desc = 'Open netrw' }},
  {'nviC', '<C-s>', 'w', { desc = 'Save buffer' }},
  {'nC', '<BS>L', 'Lazy', { desc = 'Open lazy.nvim GUI' }},
  {'nC', '<BS>I', 'Inspect', { desc = 'Inspect highlight group under cursor' }},
  {'n', 'Q', ''}, -- remove Q keybind (re-run last macro) - use `@@` instead
  
  -- Toggle UI/features
  {'nC!', '<A-w>', 'set wrap!', { desc = 'Toggle line wrap' }},
  {'nC', '<A-r>', 'set relativenumber!', { desc = 'Toggle relative numbers' }},
  {'n', '<A-s>', function() helpers.toggle_global_status() end, { desc = 'Toggle global status line' }},
  {'n!', '<A-c>', function() helpers.toggle_whitespace_hl(options.custom_opts.whitespace_hl) end, { desc = 'Toggle show whitespace' }},

  {'nv', '<leader>y', '"*y', { desc = 'Global yank' }},
  {'nv', '<leader>d', '"_d', { desc = 'Delete without copy' }},
  {'nv', 'gg', 'gg0', { desc = 'Go to very start of buffer' }},
  {'nv', 'G', 'G$', { desc = 'Go to very end of buffer' }},
  {'n', 'Y', 'y$', { desc = 'Yank to end of line' }},
  {'n', 'J', 'mzJ`z', { desc = 'Join lines (without moving cursor)' }},
  {'n', '=*', 'mzgg=G`zzz', { desc = 'Indent entire file' }},

  -- buffer navigation
  {'nvC', '<A-Down>', 'bnext', { desc = 'Next buffer' }},
  {'nvC', '<A-Up>', 'bprev', { desc = 'Previous buffer' }},
  {'nvC', '<A-BS>', 'bdelete', { desc = 'Delete buffer' }},

  -- window control
  -- creation / deletion
  {'nvC', '<C-w>|', 'vsplit', { desc = 'Split window horizontally' }},
  {'nvC', '<C-w>_', 'split', { desc = 'Split window vertically' }},
  {'nvC', '<A-.>', 'vsplit', { desc = 'Split window horizontally' }},
  {'nvC', '<A-,>', 'split', { desc = 'Split window vertically' }},
  {'n', '<C-w>x', '<C-w>c', { desc = 'Close window' }},
  {'n', '<A-/>', '<C-w>c', { desc = 'Close window' }},
  {'nC', 'QQ', 'q', { desc = 'Quit (:q)' }},
  {'nC', '<C-w>QQ', 'qa', { desc = 'Quit all (:qa)' }},
  {'nC', '<C-w>ZZ', 'wqa', { desc = 'Write and quit all (:wqa)' }},
  -- copy/pasting/rotating buffers
  {'nC', '<A-y>', 'lua lpke_copy_buffer_id()', { desc = 'Yank current buffer details' }},
  {'nC', '<A-p>', 'lua lpke_paste_buffer_id()', { desc = 'Paste yanked buffer details' }},
  {'n', '<A-o>', '<C-w>r', { desc = 'Rotate windows in current split' }},
  -- navigation
  {'nv', '<A-h>', '<C-w>h', { desc = 'Focus window left' }},
  {'nv', '<A-j>', '<C-w>j', { desc = 'Focus window down' }},
  {'nv', '<A-k>', '<C-w>k', { desc = 'Focus window up' }},
  {'nv', '<A-l>', '<C-w>l', { desc = 'Focus window right' }},
  {'i', '<A-h>', '<Esc><C-w>h', { desc = 'Focus window left' }},
  {'i', '<A-j>', '<Esc><C-w>j', { desc = 'Focus window down' }},
  {'i', '<A-k>', '<Esc><C-w>k', { desc = 'Focus window up' }},
  {'i', '<A-l>', '<Esc><C-w>l', { desc = 'Focus window right' }},
  -- resizing
  {'nv', '<A-K>', '<C-w>+<C-w>+<C-w>+', { desc = 'Increase window height' }},
  {'nv', '<A-J>', '<C-w>-<C-w>-<C-w>-', { desc = 'Decrease window height' }},
  {'nv', '<A-H>', '<C-w><<C-w><<C-w><', { desc = 'Decrease window width' }},
  {'nv', '<A-L>', '<C-w>><C-w>><C-w>>', { desc = 'Increase window width' }},
  -- zooming
  {'n', '<C-w>z', '<C-w>|<C-w>_', { desc = '"Zoom" current window horizontally and vertically' }},
  {'n', '<A-z>', '<C-w>|<C-w>_', { desc = '"Zoom" current window horizontally and vertically' }},
  {'n', '<A-;>', '<C-w>=', { desc = 'Equalise split windows' }},

  -- tab control
  -- creation / deletion
  {'nC', '<C-w>c', 'tabnew', { desc = 'Create a new tab (blank file)' }},
  {'nC', '<C-w>C', 'tab split', { desc = 'Create a new tab (clone current buffer)' }},
  {'nC', '<C-w>&', 'tabclose', { desc = 'Close current tab' }},
  {'nC', '<A-n>', 'tabnew', { desc = 'Create a new tab (blank file)' }},
  -- navigating
  {'nv', '<C-w><Right>', 'gt', { desc = 'Next Tab (right)' }},
  {'nv', '<C-w><Left>', 'gT', { desc = 'Previous Tab (left)' }},
  {'nv', '<A-Right>', 'gt', { desc = 'Next Tab (right)' }},
  {'nv', '<A-Left>', 'gT', { desc = 'Previous Tab (left)' }},

  -- arrow-key scrolling
  {'nv', '<Down>', '4<C-e>', { desc = 'Scroll down (4 lines)' }},
  {'nv', '<Up>', '4<C-y>', { desc = 'Scroll up (4 lines)' }},
  {'nv', '<S-Down>', '6zl', { desc = 'Scroll right (6 columns)' }},
  {'nv', '<S-Up>', '6zh', { desc = 'Scroll left (6 columns)' }},

  -- center cursor when down/up page
  {'nv', '<C-d>', '<C-d>zz', { desc = 'Scroll down half a screen (center cursor)' }},
  {'nv', '<C-u>', '<C-u>zz', { desc = 'Scroll up half a screen (center cursor)' }},
  {'nv', '<C-j>', '<C-d>zz', { desc = 'Scroll down half a screen (center cursor)' }},
  {'nv', '<C-k>', '<C-u>zz', { desc = 'Scroll up half a screen (center cursor)' }},

  -- center cursor when searching
  {'n', 'n', 'nzzzv', { desc = 'Next search result (center cursor)' }},
  {'n', 'N', 'Nzzzv', { desc = 'Previous search result (center cursor)' }},

  -- horizontal mouse scrolling
  {'nv', '<A-ScrollWheelDown>', '6zl', { desc = 'Scroll right' }},
  {'nv', '<A-ScrollWheelUp>', '6zh', { desc = 'Scroll left' }},
  {'i', '<A-ScrollWheelDown>', '<Esc>6zl', { desc = 'Scroll right' }},
  {'i', '<A-ScrollWheelUp>', '<Esc>6zh', { desc = 'Scroll left' }},

  -- move selected code up/down
  {'v', 'J', [[:m '>+1<CR>gv=gv]], { desc = 'Move selected lines down' }},
  {'v', 'K', [[:m '<-2<CR>gv=gv]], { desc = 'Move selected lines up' }},

  -- wrapped line traversing
  {'nE', 'j', 'v:count ? "j" : "gj"', { desc = 'Move cursor down a line (works with wrapped lines)' }},
  {'nE', 'k', 'v:count ? "k" : "gk"', { desc = 'Move cursor up a line (works with wrapped lines)' }},

  -- keep current reg when pasting over selected text
  {'v', 'p', 'P', { desc = 'Paste (preserve " register)' }},
  {'v', 'P', 'p', { desc = 'Paste (default behavior)' }},

  -- repeatable multiline indentation
  {'v', '<', '<gv', { desc = 'Indent -1 level (repeatable)' }},
  {'v', '>', '>gv', { desc = 'Indent 1 level (repeatable)' }},

  -- include char under cursor when d/c/y backwards
  {'n', 'db', 'vbd', { desc = 'Delete b (including under cursor)' }},
  {'n', 'cb', 'vbc', { desc = 'Change b (including under cursor)' }},
  {'n', 'yb', 'vby', { desc = 'Yank b (including under cursor)' }},
  {'n', 'dB', 'vBd', { desc = 'Delete B (including under cursor)' }},
  {'n', 'cB', 'vBc', { desc = 'Change B (including under cursor)' }},
  {'n', 'yB', 'vBy', { desc = 'Yank B (including under cursor)' }},
  {'n', 'd^', 'v^d', { desc = 'Delete ^ (including under cursor)' }},
  {'n', 'c^', 'v^c', { desc = 'Change ^ (including under cursor)' }},
  {'n', 'y^', 'v^y', { desc = 'Yank ^ (including under cursor)' }},
  {'n', 'd0', 'v0d', { desc = 'Delete 0 (including under cursor)' }},
  {'n', 'c0', 'v0c', { desc = 'Change 0 (including under cursor)' }},
  {'n', 'y0', 'v0y', { desc = 'Yank 0 (including under cursor)' }},

  -- dont include surrounding whitespace in a'|a"|a` motions
  {'v', [[a']], [[2i']], { desc = [[Select outer ' (no whitespace)]] }},
  {'v', [[a"]], [[2i"]], { desc = [[Select outer " (no whitespace)]] }},
  {'v', [[a`]], [[2i`]], { desc = [[Select outer ` (no whitespace)]] }},
  {'n', [[da']], [[d2i']], { desc = [[Delete outer ' (no whitespace)]] }},
  {'n', [[da"]], [[d2i"]], { desc = [[Delete outer " (no whitespace)]] }},
  {'n', [[da`]], [[d2i`]], { desc = [[Delete outer ` (no whitespace)]] }},
  {'n', [[ca']], [[c2i']], { desc = [[Change outer ' (no whitespace)]] }},
  {'n', [[ca"]], [[c2i"]], { desc = [[Change outer " (no whitespace)]] }},
  {'n', [[ca`]], [[c2i`]], { desc = [[Change outer ` (no whitespace)]] }},
  {'n', [[ya']], [[y2i']], { desc = [[Yank outer ' (no whitespace)]] }},
  {'n', [[ya"]], [[y2i"]], { desc = [[Yank outer " (no whitespace)]] }},
  {'n', [[ya`]], [[y2i`]], { desc = [[Yank outer ` (no whitespace)]] }},

  -- find and replace
  {'nv', 'S', ''}, -- clear default S functionality
  {'n', 'SS', ':s/', { desc = 'Replace in current line' }},
  {'n', 'SF', ':%s/', { desc = 'Replace in current file' }},
  {'n', 'SV', [[:'<,'>s/\%V]], { desc = 'Replace in prev selection' }},
  {'v', 'SV', [[:s/\%V]], { desc = 'Replace in current selection' }},
  {'n', 'S**', [[:%s/\<<c-r><c-w>\>/<c-r><c-w>/gi<left><left><left>]],
    { desc = 'Replace under cursor (whole file)' }},
  {'n', 'S*v', [[:'<,'>s/\%V\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Replace under cursor (prev selection)' }},
  {'n', 'S*V', [[:'<,'>s/\%V\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Replace under cursor (prev selection)' }},
}
helpers.keymap_set_multi(keymaps)

-- yank still: prevent cursor movement after yanking
helpers.keymap_set_yank_still_upwards(100)
helpers.keymap_set_yank_still_marks()

-- convert windows line endings to unix when pasting from global registers
if helpers.is_wsl then
  keymap_set({'nv!', '"*p', function() helpers.paste_unix('*') end,
    { desc = 'Paste from * register (converting to unix line endings)' }})
  keymap_set({'nv!', '"+p', function() helpers.paste_unix('+') end,
    { desc = 'Paste from + register (converting to unix line endings)' }})
end

-- disabling shortcuts of :read to prevent accidental activation when typing :reg
vim.cmd('cabbrev r echo "shorthand for :read disabled"')
vim.cmd('cabbrev re echo "shorthand for :read disabled"')
vim.cmd('cabbrev rea echo "shorthand for :read disabled"')

