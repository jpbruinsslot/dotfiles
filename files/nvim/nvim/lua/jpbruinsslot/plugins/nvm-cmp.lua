-- nvim-cmp: autocompletion
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",           -- source for text in buffer
        "hrsh7th/cmp-path",             -- source for file system paths
        "L3MON4D3/LuaSnip",             -- snippet engine
        "saadparwaiz1/cmp_luasnip",     -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim",         -- vs-code like pictograms
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            -- configure how nvim-cmp interacts with snippet engine
            snippet = { 
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(), -- select previous item in completion menu
                ["<C-n>"] = cmp.mapping.select_next_item(), -- select next item in completion menu
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),    -- scroll documentation window up
                ["<C-f>"] = cmp.mapping.scroll_docs(4),     -- scroll documentation window down
                ["<C-Space>"] = cmp.mapping.complete(),     -- show completion menu
                ["<C-e>"] = cmp.mapping.close(),            -- close completion menu
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace, select = true,
                }),                                         -- confirm completion
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),                        -- select next item in completion menu
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),                         -- select previous item in completion menu
            },
            -- source for autocompletion
            sources = {
                { name = "nvim_lsp" }, -- our lsp's so we can get autocompletion from it
                { name = "luasnip" }, -- snippets
                { name = "buffer" }, -- text within current buffer
                { name = "path" }, -- file system paths
            },
            -- configure borders for completion menu and documentation window
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = lspkind.cmp_format(),
            }
        })
    end,
}
