local builtin = require("telescope.builtin")

-- Fuzzy search through the output of git ls-files command, respects .gitignore
vim.keymap.set("n", "<C-P>", builtin.git_files, {})

-- Lists files in your current working directory, respects .gitignore
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})

-- vim.keymap.set("n", "<C-G>", function()
--     builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
--

-- Search for a string in your current working directory and get results live
-- as you type, respects .gitignore. (Requires ripgrep)
vim.keymap.set("n", "<C-G>", builtin.live_grep)

-- Lists available help tags and opens a new window with the relevant help info
-- on <cr>
vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
