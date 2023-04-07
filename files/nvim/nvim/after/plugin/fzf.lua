-- Key mappings
vim.keymap.set("n", "<C-P>", ":Files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-G>", ":Rg<CR>", { noremap = true, silent = true })

vim.g.fzf_layout = {
    window = {
        width = 0.75,
        height = 0.75,
        border = "rounded",
    },
}

vim.g.fzf_colors = {
    fg = { "fg", "Normal" },
    bg = { "bg", "Normal" },
    hl = { "fg", "Comment" },
    pointer = { "fg", "Error" },
    info = { "fg", "PreProc" },
    spinner = { "fg", "PreProc" },
    header = { "fg", "PreProc" },
    prompt = { "fg", "Conditional" },
    marker = { "fg", "Statement" },
}
