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
                "<Leader>st",
                function()
                    Snacks.picker.todo_comments()
                end,
                desc = "Todo",
            },
        },
    },
}
