-- nord: colorscheme
return {
    "nordtheme/vim",
    priortity = 1000, -- make sure to load this before all the other plugins
    config = function()
        -- Load the colorscheme
        vim.cmd("colorscheme nord")

        vim.g.nord_italic = 1
        vim.g.nord_italic_comments = 1
        vim.g.nord_uniform_diff_background = 1

        -- Make it transparent
        vim.cmd "hi Normal      ctermbg=none guibg=none"
        vim.cmd "hi SignColumn  ctermbg=none guibg=none"
        vim.cmd "hi VertSplit   ctermbg=none guibg=none"
    end,
}
