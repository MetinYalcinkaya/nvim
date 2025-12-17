return {
    {
        "folke/trouble.nvim",
        opts = {
            warn_no_results = false,
            open_no_results = true,
        },
        keys = { { "<Leader>xx", desc = "Diagnostics (Trouble)" } },
        config = function(_, opts)
            require("trouble").setup(opts)
            local trouble = require("trouble")
            vim.keymap.set("n", "<Leader>xx", function()
                trouble.toggle("diagnostics")
            end, { desc = "Diagnostics (Trouble)" })
            vim.keymap.set("n", "<Leader>xX", function()
                trouble.toggle({ mode = "diagnostics", filter = { buf = 0 } })
            end, { desc = "Buffer Diagnostics (Trouble)" })
            vim.keymap.set("n", "<Leader>cs", function()
                trouble.toggle({ mode = "symbols", focus = false })
            end, { desc = "Symbols (Trouble)" })
            vim.keymap.set("n", "<Leader>cl", function()
                trouble.toggle({ mode = "lsp", focus = false, win = { position = "right" } })
            end, { desc = "LSP Definitions / References / ... (Trouble)" })
            vim.keymap.set("n", "<Leader>xL", function()
                trouble.toggle({ mode = "loclist" })
            end, { desc = "Location List (Trouble)" })
            vim.keymap.set("n", "<Leader>xQ", function()
                trouble.toggle({ mode = "qflist" })
            end, { desc = "Quickfix List (Trouble)" })
        end,
    },
}
