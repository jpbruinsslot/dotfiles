vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.g.nord_uniform_diff_background = 1

vim.cmd.colorscheme("nord")

-- Make it transparent
vim.cmd "hi Normal      ctermbg=none guibg=none"
vim.cmd "hi SignColumn  ctermbg=none guibg=none"
vim.cmd "hi VertSplit   ctermbg=none guibg=none"
