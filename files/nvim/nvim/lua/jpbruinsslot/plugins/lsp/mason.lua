-- mason : install and manage all your language servers
return {
    "williamboman/mason.nvim",
    dependencies =  {
        -- Acts like a brdige between mason and lspconfig
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({

            -- list of servers for mason to install
            ensure_installed = {
                "clangd",
                "gopls",
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "bashls",
            },

            -- auto-install  configure servers (with lspconfig)
            automatic_installation = true,
        })
    end,
}
