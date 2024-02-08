------------------------------------------------------------------------------
-- General
------------------------------------------------------------------------------

-- Set autoread to true, when files are changed outside of vim, reload them
vim.opt.autoread = true

------------------------------------------------------------------------------
-- User interface
------------------------------------------------------------------------------

-- Allow backspacing over everything in insert mode
vim.opt.backspace = "indent,eol,start"

-- Cursorline
vim.opt.cursorline = true

-- Disable cursor styling
vim.opt.guicursor = ""

-- Line separator character
vim.opt.fillchars = "vert:│"

-- Ignore case when searching
vim.opt.ignorecase = true

-- When searching try to be smart about cases
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Search as characters are entered
vim.opt.incsearch = true

-- No annoying sound on errors
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Show line numbers
vim.opt.number = true

-- Display status line at bottom of vim window
vim.opt.ruler = true
--vim.opt.rulerformat = "%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)"

-- highlight matching [{()}]
vim.opt.showmatch = true

-- Show command in bottom bar
vim.opt.showcmd = true

-- Enable folding
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10

-- Cursor can move freely
vim.opt.virtualedit = "all"

-- Don't wrap lines
vim.opt.wrap = false

-- Enables true color support in the terminal emulator
vim.opt.termguicolors = true

-- Sets the number of lines to keep visible above and below the cursor when
-- scrolling.
vim.opt.scrolloff = 8

-- Enables the sign column, which is used to display signs (e.g. error/warning
-- icons) and may shift the text to the right.
vim.opt.signcolumn = "yes"

-- Appends "@-@" to the 'isfname' option, which specifies the characters that
-- are considered part of a file name. This allows file names that contain the
-- "@" character to be properly recognized and navigated to.
vim.opt.isfname:append("@-@")

-- Sets the time in milliseconds for which neovim waits after a change before
-- triggering an event (e.g. CursorHold).
vim.opt.updatetime = 50

-- Sets relative numbers
vim.opt.relativenumber = false

------------------------------------------------------------------------------
-- Text, tabs, and indents
------------------------------------------------------------------------------

-- Be smart when using tabs
vim.opt.smarttab = true

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Next line will automatically be indented by this amount
vim.opt.shiftwidth = 4

-- Tab character will be displayed as this many spaces
vim.opt.tabstop = 4

-- Prevent unintentional insertion of spaces, when using tabs
vim.opt.softtabstop = 4

------------------------------------------------------------------------------
-- Undo and backup
------------------------------------------------------------------------------

-- Disables creation of swap files to avoid cluttering the file system.
vim.opt.swapfile = false

-- Disables creation of backup files to avoid cluttering the file system.
vim.opt.backup = false

-- Sets the directory where undo files will be stored.
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Enables persistent undo, which allows undo history to be saved across
-- sessions.
vim.opt.undofile = true
