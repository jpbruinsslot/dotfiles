return {
	"lukas-reineke/virt-column.nvim",
	config = function()
		require("virt-column").update({
			char = "│",
			virtcolumn = "80",
		})
	end,
}
