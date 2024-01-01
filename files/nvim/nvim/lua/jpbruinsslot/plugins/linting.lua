-- nvim-lint: linting
--
-- url: github.com/mfussenegger/nvim-lint
return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",   -- trigger whenever we're opening an already existing file
        "BufNewFile"    -- trigger whenever we're opening a new file
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            c = { "cppcheck", "clangtidy" },
            cpp = { "cppcheck", "clangtidy" },
            go = { "golangcilint" },
            html = { "tidy" },
            json = { "jsonlint" },
            javascript = { "eslint_d" },
            less = { "stylelint" },
            markdown = { "markdownlint" },
            python = { "flake8", "mypy", "pylint", "ruff" },
            lua = { "luacheck" },
            vim = { "vint" },
            sh = { "shellcheck" },
            yaml = { "yamllint" },
            css = { "stylelint" },
            scss = { "stylelint" },
            sass = { "stylelint" },
            rust = { "cargo" },
            sql = { "sqlint" },
            dockerfile = { "hadolint" },
        }

        -- create and autocommand group that will execute on different neovim
        -- events and trigger linting. And clear any pre-existing autocmds
        -- within it 
        local lint_augroup = vim.api.nvim_create_augroup( "lint", { clear = true })

        -- list of neovim events that we want to use to trigger linting
        vim.api.nvim_create_autocmd({
            "BufEnter",    -- trigger whenever we open a new buffer or we move the cursor into another buffer
            "BufWritePost", -- trigger whenever we save a buffer
            "InsertLeave",  -- trigger whenever we leave insert mode
        },{
            group = lint_augroup,
            callback = function()   -- will trigger when any of the above events are triggered
                lint.try_lint()     -- the lint plugin which we loaded will try to execute linting
            end
        })

        -- keybindings to trigger linting manually
        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
