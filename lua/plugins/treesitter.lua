return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        opts = {},
        config = function()
            local treesitter = require("nvim-treesitter")
            local ensure_installed = {
                "bash",
                "c",
                "css",
                "html",
                "javascript",
                "latex",
                "lua",
                "markdown",
                "markdown_inline",
                "norg",
                "r",
                "regex",
                "rust",
                "scss",
                "svelte",
                "tsx",
                "typst",
                "vim",
                "vue",
                "yaml",
            }
            local already_installed = treesitter.get_installed()

            local to_install = vim.iter(ensure_installed)
                :filter(function(parser)
                    return not vim.tbl_contains(already_installed, parser)
                end)
                :totable()

            if #to_install > 0 then
                treesitter.install(to_install)
            end
        end,
    },
}
