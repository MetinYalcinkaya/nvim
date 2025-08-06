return {
    {
        "rachartier/tiny-glimmer.nvim",
        event = "VeryLazy",
        priority = 10,
        opts = {
            enabled = true,
            overwrite = {
                paste = {
                    enabled = true,
                },
                undo = {
                    enabled = true,
                },
                redo = {
                    enabled = true,
                },
            },
        },
    },
}
