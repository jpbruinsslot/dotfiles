-- mason : install and manage all your language servers
return {
	"williamboman/mason.nvim",
	dependencies = {
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

		-- Install following language servers automatically
		mason_lspconfig.setup({

			-- list of servers for mason to install
			ensure_installed = {
				"clangd",
				"gopls",
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"bashls",
				"html",
				"ts_ls",
				"somesass_ls",
				"eslint",
			},

			-- auto-install configure servers (with lspconfig)
			automatic_installation = true,
		})

		-- Install following formatter and linters automatically
		--
		-- See what linters you're using at ./plugins/linting.lua
		-- See what formatters you're using at ./plugins/formatting.lua
		mason_tool_installer.setup({
			ensure_installed = {
				-- formatters
				"black",
				"clang-format",
				"codespell",
				"goimports",
				"gofumpt",
				"isort",
				"prettier",
				"rustfmt",
				"shfmt",
				"stylua",

				-- linters
				"eslint_d",
				"flake8",
				"hadolint",
				"luacheck",
				"golangci-lint",
				"jsonlint",
				"markdownlint",
				"mypy",
				"pylint",
				"ruff",
				"shellcheck",
				"stylelint",
				"yamllint",
			},
		})
	end,
}
