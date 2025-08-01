-- conform.nvim - format files on save
--
-- url: github.com/stevearc/conform.nvim
return {
	"stevearc/conform.nvim",
	event = {
		"BufReadPre", -- trigger whenever we're opening an already existing file
		"BufNewFile", -- trigger whenever we're opening a new file
	},
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettier" },
				go = { "goimports", "gofmt" },
				html = { "prettier" },
				javascript = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier_md" }, -- use custom formatter for markdown
				python = { "isort", "ruff_format" },
				rust = { "rustfmt" },
				scss = { "prettier" },
				sass = { "prettier" },
				sh = { "shfmt" },
				yaml = { "prettier" },
				["*"] = {},
			},
			formatters = {
				prettier_md = {
					command = "prettier",
					args = {
						"--stdin-filepath",
						"$FILENAME",
						"--prose-wrap",
						"always",
						"--print-width",
						"80",
					},
					stdin = true,
				},
			},
			format_on_save = {
				lsp_fallback = true, -- if a formatter isn't available for the filetype, use lsp
				async = false, -- formatter will not run asynchronously
				timeout_ms = 500, -- timeout for formatter to finish
			},
		})

		-- Setup keybindings
		vim.keymap.set({ "n", "v" }, "<leader>ft", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
