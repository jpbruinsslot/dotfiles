require("gitsigns").setup {
    signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "┃" },
        untracked = { text = "┃" },
        topdelete = { text = "‾" },
        changedelete = { text = "~_" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
}
