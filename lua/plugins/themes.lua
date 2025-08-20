return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                float = {
                    transparent = false,
                    solid = true,
                },
                integrations = {
                    -- noice = true,
                    -- notify = true,
                    fidget = true,
                    diffview = true,
                    mason = true,
                    snacks = {
                        enabled = true,
                        indent_scope_color = "lavender",
                    },
                    native_lsp = {
                        enabled = true,
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        },
                    },
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
