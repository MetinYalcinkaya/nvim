return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        opts = {},
        config = function()
            local treesitter = require("nvim-treesitter")
            local ensure_installed = {
                "bash",
                "c",
                "comment",
                "css",
                "diff",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "html",
                "javascript",
                "json",
                "latex",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "norg",
                "python",
                "qml",
                "query",
                "regex",
                "rust",
                "scss",
                "svelte",
                "toml",
                "tsx",
                "typescript",
                "typst",
                "vim",
                "vimdoc",
                "vua",
                "xml",
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
