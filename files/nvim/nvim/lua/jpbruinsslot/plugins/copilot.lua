-- copilot: code completion
return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_assume_mapped = true
		vim.keymap.set("n", "<leader>cp", ":Copilot<CR>")
		vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>")
		vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>")
	end,
}
