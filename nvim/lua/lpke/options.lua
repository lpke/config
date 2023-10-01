local is_wsl = vim.fn.exists('$WSL_DISTRO_NAME')

local options = {
  --backup = false, -- no backups
  --swapfile = false, -- don't create a swapfile
  clipboard = '', -- setting this to anything else will make pasting very slow on WSL
  cmdheight = 1, -- set height of command-line to 1
  conceallevel = 0, -- show text normally
  --fileencoding = 'utf-8', -- file encoding for current buffer
  hlsearch = false, -- don't highlight matches
  incsearch = true, -- show the pattern matches as i type
  mouse = 'a', -- enable mouse for all modes (including commands)
  --pumheight = 5, -- set the popup menu height to 10
  termguicolors = true, -- enables 24-bit color in tui
  splitbelow = true, -- open new horizontal splits below current buffer
  splitright = true, -- open new vertical splits to the right of current buffer
  --timeoutlen = 1000, -- length of timeout for commands like 'jk' for exit
  number = true, -- set line numbers, this setting shows the line number you're currently on
  relativenumber = true, -- make the line numbers relative to active line
  numberwidth = 4, -- the width of the number column, setting it to 4 keeps it from pushing the editor over as numbers get larger
  --cindent = true, -- for C files, which I do not write right now.
  --signcolumn = 'yes', -- show signs in signcolumn
  wrap = false, -- line wrap
  breakindent = true, -- wrapped text is indented to that line's indent level
  --laststatus = 3, -- global statusline, thanks Neovim team :-)
  tabstop = 2, -- maximum width of an actual tab character
  softtabstop = 2, -- number of spaces a tab counts for during editing operations
  shiftwidth = 2, -- the size of code indents
  expandtab = true, -- always expand tab to spaces
  smarttab = true, -- tab inserts whitespace only to the next predefined tab stop
  shiftround = true, -- when indenting, stop at next shiftwidth (don't end up in between stops)
  --guicursor = "n-v-c-i:block", -- i'll block you
  --guifont = "Iosevka Nerd Font Medium:h14", -- the font the bible is written in.
  --shellxquote = "", -- i can use this to do cool things
  autoindent = true, -- this should absolutely always be on
  smartindent = true, -- so should this.
  scrolloff = 8, -- minumum number of lines to keep above/below cursor
  sidescrolloff = 8, -- minumum number of char columns to keep left/right of cursor
  --equalalways = false, -- all windows are made the same size after opening or closing
  ignorecase = true, -- ignore case of letters when searching (see also \c)
  smartcase = true, -- dont ignore case if search contains capitals (see also \C)
}

-- convert above table into: vim.opt.<option> = <value>
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- wsl clipboard support
if is_wsl then
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
end

-- disable next line auto-comment
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- netrw settings
vim.g.netrw_banner = 0

