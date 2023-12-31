return {
    "gcmt/taboo.vim",
    config = function()
        -- Rename tab
         vim.keymap.set("n", "tr", ":TabooRename<space>")

        -- Tab format
        -- %N            tabnumber number on each tab
        -- %m            modified flag
        -- %f            name of the first buffer open in the tab
        vim.g.taboo_tab_format = " %N %f %m "

        -- Renamed tab format
        -- %N            tabnumber number on each tab
        -- %l            custom tab name
        -- %m            modified flag
        vim.g.taboo_renamed_tab_format = " %N %l %m "

        -- Modified flag
        vim.g.taboo_modified_tab_flag = "•"
    end,
}
