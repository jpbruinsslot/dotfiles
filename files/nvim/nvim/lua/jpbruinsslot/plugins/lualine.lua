return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				disabled_filetypes = { statusline = { "neo-tree" } },
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { right = "" },
						fmt = function(str)
							return " " .. str
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						separator = { right = "" },
					},
				},
				lualine_c = { "filename" },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "neo-tree" },
		})
	end,
}
