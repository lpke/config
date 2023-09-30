-- remap leader to space
vim.g.mapleader = " "

-- open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- package manager
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

-- window (pane) navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- TODO tab navigation


-- horizontal mouse scrolling
vim.keymap.set("n", "<A-ScrollWheelDown>", "6zl")
vim.keymap.set("n", "<A-ScrollWheelUp>", "6zh")
