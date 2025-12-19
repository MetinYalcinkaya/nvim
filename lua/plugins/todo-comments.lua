return {
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = { signs = false },
        keys = {
            {
                "<Leader>ft",
                function()
                    require("todo-comments.fzf").todo()
                end,
                desc = "Todo",
            },
        },
    },
}
