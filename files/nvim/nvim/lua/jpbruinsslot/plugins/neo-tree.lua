-- neo-tree: file explorer
return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"s1n7ax/nvim-window-picker",
	},
	config = function()
		require("neo-tree").setup({
			default_component_configs = {
				indent = {
					with_markers = false,
				},
				modified = {
					symbol = "",
				},
			},
			window = {
				width = 30,
				mappings = {
					["<cr>"] = "open_with_window_picker",
					["o"] = "set_root",
					["."] = "toggle_hidden",
				},
			},
		})

		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR> <C-W>=", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>fr", ":Neotree reveal<CR>", {})
	end,
}
