-- tcomment: comment/uncomment text
return {
    "tomtom/tcomment_vim",
    config = function()
        vim.keymap.set("n", "<C-/>", "TComment<CR>")
        vim.keymap.set("v", "<C-/>", "TComment<CR>gv")
    end,
}
