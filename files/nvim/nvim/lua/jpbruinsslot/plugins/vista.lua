-- vista.vim:
return {
    "liuchengxu/vista.vim",
    config = function()
        vim.g.vista_default_executive = "nvim_lsp"
        vim.g.vista_icon_indent = { "╰─▸ ", "├─▸ " }
        vim.keymap.set("n", "<F8>", ":Vista!!<cr>")
    end,
}
