-- alpha-nvim: dashboard
return {
    "goolord/alpha-nvim",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[█▀▀█ █ █  █▀█  █▀▀█ █▀▀ █▀▀█]],
            [[█▄▀█ ▄▀▄ █▄▄█▄ █▄▄█ ▀▀▄ █▄▀█]],
            [[█▄▄█ █ █    █  █  █ ▄▄▀ █▄▄█]],
        }

        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
            dashboard.button("h", "  Recently opened files", ":Telescope oldfiles <CR>"),
            dashboard.button("b", "  Bookmarks", ":Telescope marks <CR>"),
            dashboard.button("c", "  Load last session", ":source Session.vim <CR>"),
            dashboard.button("q", "  Quit", ":qa <CR>"),
        }

        alpha.setup(dashboard.opts)
    end,
}
