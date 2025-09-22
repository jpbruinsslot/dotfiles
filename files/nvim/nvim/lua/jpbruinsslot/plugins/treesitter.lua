-- nvim-treesitter: incremental parsing
--
-- Provides advanced syntax highlighting and parsing capabilities. It leverages
-- the Treesitter library, which is a parsing system that understands the
-- structure of code in a more sophisticated way than traditional regular
-- expressions-based syntax highlighting.
return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = {
					enable = true,
				},
				-- ensure these language parsers are installed
				ensure_installed = {
					"bash",
					"c",
					"css",
					"csv",
					"dockerfile",
					"gitignore",
					"go",
					"html",
					"json",
					"javascript",
					"typescript",
					"lua",
					"markdown",
					"markdown_inline",
					"query",
					"rust",
					"svelte",
					"tsv",
					"vim",
					"vimdoc",
					"yaml",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
}
