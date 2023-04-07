vim.cmd [[packadd packer.nvim]]

vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use('wbthomason/packer.nvim')

    -- telescope-nvim: fuzzy finder
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = {
            { "nvim-lua/plenary.nvim" }
        },
    })

    -- lsp-zero: LSP client
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    })

    -- nord: colorscheme
    use("nordtheme/vim")

    -- lightline: light and configurable statusline/tabline for vim
    use("itchyny/lightline.vim")

    -- treesitter: incremental parsing
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- treesitter: playground
    use("nvim-treesitter/playground")

    -- undotree: visualize undo history
    use("mbbill/undotree")

    -- neo-tree: file explorer
    use({
        "nvim-neo-tree/neo-tree.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker",
        }
    })

    -- taboo.vim: tabline
    use("gcmt/taboo.vim")

    -- alpha-nvim: dashboard
    use({
        "goolord/alpha-nvim",
        config = function()
            require 'alpha'.setup(require "alpha.themes.dashboard".config)
        end
    })

    -- copilot: code completion
    use("github/copilot.vim", { branch = "stable" })

    -- indent-blankline: show indent lines
    use("lukas-reineke/indent-blankline.nvim")

    -- zen-mode: distraction-free writing
    use("folke/zen-mode.nvim")

    -- trouble: show diagnostics
    use({
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    -- gitsign: git sign column for neovim
    use("lewis6991/gitsigns.nvim")

    -- tcomment: comment/uncomment text
    use("tomtom/tcomment_vim")

    -- autopairs: insert or delete brackets, parens, quotes in pair
    use("jiangmiao/auto-pairs")
end)
