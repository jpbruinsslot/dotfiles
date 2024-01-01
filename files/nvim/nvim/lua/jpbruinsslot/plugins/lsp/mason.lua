-- mason : install and manage all your language servers
return {
    "williamboman/mason.nvim",
    dependencies =  {
        -- Acts like a bridge between mason and lspconfig
        "williamboman/mason-lspconfig.nvim",

        -- Auto install formatters and linters, whenever we start neovim up
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- *** define the servers we want to install automatically ***
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

        -- *** define the formatters and linters we want to install automatically ***
        mason_tool_installer.setup({
            ensure_installed = {
                -- formatters
                "prettier",
                "rustfmt",
                "black",
                "isort",
                "shfmt",

                -- linters
                "eslint_d",
            },
        })
    end,
}
