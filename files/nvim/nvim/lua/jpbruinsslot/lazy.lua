-- bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- setup lazy.nvim
require("lazy").setup({
	-- import your plugins
	{ import = "jpbruinsslot.plugins" },
	{ import = "jpbruinsslot.plugins.lsp" },
}, {
	install = {
		colorscheme = { "catppuccin/nvim" }, -- colorscheme that will be used when installing plugins.
	},
	checker = {
		enabled = true, -- automatically check for plugin updates
		notify = false, -- don't notify on every check
		frequency = 604800, -- check every 7 days (in seconds)
	},
})
