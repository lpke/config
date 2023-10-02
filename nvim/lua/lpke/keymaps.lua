local helpers = require('helpers')

-- remap leader to space
vim.g.mapleader = ' '

--------------------------
-- KEYMAPS
-- 'modes/extras', <from>, <to>, {opts}
-- extras: N=noremap, !=silent
--------------------------
local keymaps = {
  -- window (pane) navigation
  {'n', '<C-h>', '<C-w>h'},
  {'n', '<C-j>', '<C-w>j'},
  {'n', '<C-k>', '<C-w>k'},
  {'n', '<C-l>', '<C-w>l'},

  -- open netrw
  {'n', '<leader>pv', vim.cmd.Ex},

  -- package manager
  {'n', '<leader>L', '<cmd>Lazy<cr>'},

  -- tab navigation
  -- TODO

  -- horizontal mouse scrolling
  {'n', '<A-ScrollWheelDown>', '6zl'},
  {'n', '<A-ScrollWheelUp>', '6zh'},

  -- toggle line wrap
  {'nN!', '<C-w>w', ':set wrap!<CR>'},
}
helpers.set_keymaps(keymaps)

-- fix windows line endings when pasting from global registers
if helpers.is_wsl then
  function fix_line_endings(register)
    local content = vim.fn.getreg(register)
    local fixed_content = vim.fn.substitute(content, '\r\n', '\n', 'g')
    vim.fn.setreg(register, fixed_content)
    vim.cmd('normal! "' .. register .. 'p')
  end
  vim.keymap.set('n', '"*p', ':lua fix_line_endings("*")<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '"+p', ':lua fix_line_endings("+")<CR>', { noremap = true, silent = true })
end

