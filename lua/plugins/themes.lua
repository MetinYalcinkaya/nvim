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
    -- {
    --   "folke/tokyonight.nvim",
    --   lazy = false,
    --   priority = 1000,
    --   config = function()
    --     require("tokyonight").setup({
    --       style = "moon",
    --       styles = {
    --         -- floats = "transparent",
    --       },
    --       transparent = false,
    --       lualine_bold = true,
    --     })
    --     vim.cmd.colorscheme("tokyonight")
    --   end,
    -- },
    -- {
    --   "rose-pine/neovim",
    --   dir = "~/Developer/rose-pine/neovim/",
    --   name = "rose-pine",
    --   priority = 1000,
    --   config = function()
    --     require("rose-pine").setup({
    --       variant = "main",
    --       styles = {
    --         transparency = true,
    --       },
    --     })
    --     vim.cmd.colorscheme("rose-pine")
    --   end,
    -- },
    -- {
    --   "olimorris/onedarkpro.nvim",
    --   -- dir = "~/Developer/onedarkpro.nvim/",
    --   lazy = false,
    --   priority = 1000,
    --   config = function()
    --     require("onedarkpro").setup({
    --       highlights = {
    --         NormalFloat = { bg = "NONE" },
    --         FloatBorder = { fg = "${gray}", bg = "${bg}" },
    --       },
    --       styles = {
    --         comments = "italic",
    --         methods = "bold",
    --         functions = "bold",
    --         keywords = "italic",
    --         parameters = "italic",
    --         conditionals = "italic",
    --         virtual_text = "italic",
    --       },
    --       options = {
    --         cursorline = true,
    --       },
    --     })
    --     vim.cmd.colorscheme("onedark")
    --   end,
    -- },
}
