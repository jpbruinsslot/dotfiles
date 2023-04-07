require("neo-tree").setup({
    default_component_configs = {
        indent = {
            with_markers = false,
        },
    },
    window = {
        mappings = {
            ["<cr>"] = "open_with_window_picker",
            ["o"] = "set_root",
            ["."] = "toggle_hidden",
        }
    },
})

vim.keymap.set("n", "<C-n>", ":Neotree<CR>", { noremap = true, silent = true })
