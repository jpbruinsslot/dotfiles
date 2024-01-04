-- alpha-nvim: dashboard
return {
	"goolord/alpha-nvim",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[ ██████╗ ██╗  ██╗██╗  ██╗ █████╗ ███████╗ ██████╗ ]],
			[[██╔═████╗╚██╗██╔╝██║  ██║██╔══██╗██╔════╝██╔═████╗]],
			[[██║██╔██║ ╚███╔╝ ███████║███████║███████╗██║██╔██║]],
			[[████╔╝██║ ██╔██╗ ╚════██║██╔══██║╚════██║████╔╝██║]],
			[[╚██████╔╝██╔╝ ██╗     ██║██║  ██║███████║╚██████╔╝]],
			[[ ╚═════╝ ╚═╝  ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("x", "  > Toggle file explorer", "<cmd>Neotree toggle<CR>"),
			dashboard.button("f", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("w", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("b", "  > Bookmarks", ":Telescope marks <CR>"),
			dashboard.button("h", "  > Recently opened files", ":Telescope oldfiles <CR>"),
			dashboard.button("c", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
