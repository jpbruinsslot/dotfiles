-- indent-blankline: show indent lines
return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		local highlight = {
			"CurrentScope",
		}
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "CurrentScope", { fg = "#88C0D0" })
		end)

		require("ibl").setup({
			indent = {
				char = "│",
			},
			scope = {
				highlight = highlight,
			},
		})
	end,
}
