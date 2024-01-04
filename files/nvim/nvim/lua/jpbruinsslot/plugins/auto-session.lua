return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		local function close_neo_tree()
			require("neo-tree.sources.manager").close_all()
		end

		local function open_neo_tree()
			require("neo-tree.sources.manager").show("filesystem")
		end

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Projects/", "~/Downloads", "~/Documents", "~/Desktop/" },
			pre_save_cmds = { close_neo_tree },
			post_restore_cmds = { open_neo_tree },
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
		keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
	end,
}
