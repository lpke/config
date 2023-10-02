local is_wsl = vim.fn.exists('$WSL_DISTRO_NAME')

-- remap leader to space
vim.g.mapleader = ' '

-- open netrw
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- package manager
vim.keymap.set('n', '<leader>L', '<cmd>Lazy<cr>')

-- window (pane) navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- TODO tab navigation


-- horizontal mouse scrolling
vim.keymap.set('n', '<A-ScrollWheelDown>', '6zl')
vim.keymap.set('n', '<A-ScrollWheelUp>', '6zh')

-- toggle line wrap
vim.keymap.set('n', '<C-w>w', ':set wrap!<CR>', { noremap = true, silent = true })

-- fix windows line endings when pasting from global registers
if is_wsl then
  function fix_line_endings(register)
    local content = vim.fn.getreg(register)
    local fixed_content = vim.fn.substitute(content, '\r\n', '\n', 'g')
    vim.fn.setreg(register, fixed_content)
    vim.cmd('normal! "' .. register .. 'p')
  end
  vim.keymap.set('n', '"*p', ':lua fix_line_endings("*")<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '"+p', ':lua fix_line_endings("+")<CR>', { noremap = true, silent = true })
end

