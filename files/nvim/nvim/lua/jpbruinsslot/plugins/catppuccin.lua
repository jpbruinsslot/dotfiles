-- catppuccin: colorscheme
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priortity = 1000, -- make sure to load this before all the other plugins
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",
			transparent_background = true,
		})

		-- Load the colorscheme
		vim.cmd("colorscheme catppuccin")
	end,
}
