-- Remap leader to space
vim.g.mapleader = ","

-- Remap escape to also remove highlighting from search
vim.keymap.set("n", "<Esc>", ":noh<CR>")

-- Remap remove word to ctrl + backspace (used on system)
vim.keymap.set("i", "<C-BS>", "<C-w>")

-- Smart way to move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Quickly resize windows with a vertical split
vim.keymap.set("n", "-", "<C-W>-")
vim.keymap.set("n", "+", "<C-W>+")

-- Split window with a vertical split
vim.keymap.set("n", "<leader>v", "<C-W>v")

-- Split window with a horizontal split
vim.keymap.set("n", "<leader>h", "<C-W>s")

-- Even split panel size
vim.keymap.set("n", "<leader>=", "<C-W>=")

-- Useful mappings for managing tabs
vim.keymap.set("n", "tt", ":tabnew<CR>")
vim.keymap.set("n", "tc", ":tabclose<CR>")
vim.keymap.set("n", "tm", ":tabmove<CR>")
vim.keymap.set("n", "tr", ":tabrename<CR>")

-- Tab navigation
vim.keymap.set("n", "tn", ":tabprevious<CR>")
vim.keymap.set("n", "to", ":tabnext<CR>")

-- Opens a new tab with the current buffer's path
vim.keymap.set("n", "<leader>te", ":tabedit %:p:h<CR>")

-- Wrapped lines goes down/up to next row, rather than next line file.
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

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

-- Paste into the '+'' register (system clipboard)
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Paste from the '+'' register (system clipboard)
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("i", "<leader>p", "<C-r>+")
vim.keymap.set("v", "<leader>p", '"+p')

-- Don't loose current paste buffer when pasting
vim.keymap.set("x", "<leader>P", '"_dP')

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

-- Save file
vim.keymap.set("n", "<leader>s", ":w<CR>")
vim.keymap.set("n", "<leader>S", ":wq<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")

-- Exit all windows and save
vim.keymap.set("n", "<leader>w", ":wa<CR>")
vim.keymap.set("n", "<leader>W", ":xa<CR>")
