-- indent-blankline: show indent lines
return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		vim.api.nvim_set_hl(0, "CurrentScope", { fg = "#88C0D0" })

		require("ibl").setup({
			indent = {
				char = "│",
			},
			scope = {
				highlight = "CurrentScope",
			},
		})
	end,
}
