return {
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                -- python = { "ruff" },
                swift = { "swiftlint" },
                -- cpp = { 'clangtidy' },
            }

            local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "CursorMoved", "CursorMovedI" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
            vim.keymap.set("n", "<Leader>l", function()
                lint.try_lint()
            end, { desc = "Lint buffer" })
        end,
    },
}
