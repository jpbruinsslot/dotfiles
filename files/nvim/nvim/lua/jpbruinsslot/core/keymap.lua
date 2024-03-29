-- Remap leader to space
vim.g.mapleader = ","

-- Smart way to move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Quickly resize windows with a vertical split
vim.keymap.set("n", "-", "<C-W>-")
vim.keymap.set("n", "+", "<C-W>+")

-- Even split panel size
vim.keymap.set("n", "<leader>=", "<C-W>=")

-- Useful mappings for managing tabs
vim.keymap.set("n", "tn", ":tabnew<CR>")
vim.keymap.set("n", "tc", ":tabclose<CR>")
vim.keymap.set("n", "to", ":tabonly<CR>")
vim.keymap.set("n", "tm", ":tabmove<CR>")
vim.keymap.set("n", "tr", ":tabrename<CR>")

-- Tab navigation
vim.keymap.set("n", "th", ":tabprevious<CR>")
vim.keymap.set("n", "tl", ":tabnext<CR>")

-- Opens a new tab with the current buffer's path
vim.keymap.set("n", "<leader>te", ":tabedit %:p:h<CR>")

-- Wrapped lines goes down/up to next row, rather than next line file.
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Remove highlight from search when not needed
vim.keymap.set("n", "<leader>q", ":noh<CR>")

-- Comment lines with ctrl + /
vim.keymap.set("n", "<C-/>", ":TComment<CR>")
vim.keymap.set("v", "<C-/>", ":TComment<CR>")

-- Move lines up and down when selected in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cursor to stay in place when using J
vim.keymap.set("n", "J", "mzJ`z")

-- Half page jumping, keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Don't loose current paste buffer when pasting
vim.keymap.set("x", "<leader>p", '"_dP')

-- Paste into the '+'' register (system clipboard)
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Deleting to void register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Fix for the annoying 'Q' and 'q:' commands
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<nop>")

-- Running a macro:
--  1. Start recording keystrokes by typing qq
--  2. End recording with q
--  3. Play recorded keystrokes by hitting space
-- vim.keymap.set("n", " ", "@q")

-- Quick fix navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace the word that you're on through the whole file
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
