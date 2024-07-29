return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("trouble").setup({
			auto_open = false,
			auto_close = false,
			use_diagnostic_signs = true,
		})

		vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", { silent = true, noremap = true })
	end,
}
