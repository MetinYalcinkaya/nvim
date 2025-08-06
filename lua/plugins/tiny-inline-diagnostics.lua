return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = { "BufReadPre", "BufNewFile", "VeryLazy" },
        priority = 1001,
        opts = {
            preset = "classic",
            options = {
                show_source = true,
                throttle = 0,
                multilines = {
                    enabled = true,
                    always_show = true,
                },
            },
        },
    },
}
