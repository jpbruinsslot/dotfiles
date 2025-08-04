return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	config = function()
		require("oil").setup({
			-- Your configuration goes here
			view_options = {
				show_hidden = true, -- Show hidden files
			},
			keymaps = {
				-- disabled, else I couldn't use <C-h> and <C-l> to navigate
				["<C-h>"] = false,
				["<C-l>"] = false,
			},
		})
	end,
}
