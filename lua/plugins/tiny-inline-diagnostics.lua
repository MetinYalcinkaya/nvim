return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        opts = {
            options = {
                show_source = {
                    if_many = true,
                },
                throttle = 0,
                multilines = {
                    enabled = true,
                    always_show = true,
                },
            },
            signs = {
                diag = "",
                vertical = " │",
                vertical_end = " └",
                left = "",
                right = "",
            },
            blend = {
                factor = 0.00,
            },
        },
    },
}
