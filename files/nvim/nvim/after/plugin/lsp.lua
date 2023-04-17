local lsp = require("lsp-zero")
local lsp_config = require("lspconfig")

lsp.preset("recommended")

lsp.ensure_installed({
    "clangd",
    "gopls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "bashls",
})

-- Fix Undefined global 'vim'
lsp_config.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

lsp_config.gopls.setup({
    settings = {
        gopls = {
            staticcheck = true,
        }
    },
    on_attach = function(client, bufnr)
        --print("hello from gopls")
    end
})

lsp_config.pyright.setup({
    on_attach = function(client, bufnr)
        --print("hello from pyright")
    end
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    -- If you only ever have one language server attached in each file and you
    -- are happy with all of them
    -- lsp.buffer_autoformat()
end)

-- Use the following if you want to control exactly what language server is
-- used to format a file, this will allow you to associate a language server
-- with a list of filetypes.
lsp.format_on_save({
    servers = {
        ["null-ls"] = {"python", "go", "sh", "make"}
    },
})

lsp.set_sign_icons({
    error = "",
    warn = "",
    info = "",
    hint = "",
})

lsp.setup()

-- Needs to be after lsp-zero setup
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<S-Tab>"] = nil,
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format(),
    }
})

-- https://docs.rockylinux.org/books/nvchad/custom/plugins/null_ls/
-- https://github.com/olexsmir/init.lua/blob/main/lua/plugins/lsp/null-ls.lua
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.staticcheck,
        null_ls.builtins.diagnostics.pylint.with({
            diagnostics_postprocess = function(diagnostic)
                diagnostic.code = diagnostic.message_id
            end,
        }),
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.usort,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.ruff,
    }
})

-- Will automatically install the above
local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({
    ensure_installed = nil,
    automatic_installation = true,
})
