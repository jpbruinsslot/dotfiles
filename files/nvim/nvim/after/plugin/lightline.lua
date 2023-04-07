vim.g.lightline = {
    enable = {
        statusline = 1,
        tabline = 0,
    },
    colorscheme = "nord",
    active = {
        left = {
            { "mode",      "paste" },
            { "gitbranch", "readonly", "filename", "modified" }
        }
    },
    component_function = {
        gitbranch = "fugitive#head",
        modified = "LightlineModified"
    }
}
