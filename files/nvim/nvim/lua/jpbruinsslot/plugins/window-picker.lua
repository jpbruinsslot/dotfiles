-- window-picker.lua
return {
	"s1n7ax/nvim-window-picker",
	config = function()
		require("window-picker").setup({
			selection_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
			other_win_hl_color = "#4493C8",
		})
	end,
}
