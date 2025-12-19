return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            notifier = {
                enabled = false,
                style = "minimal",
            },
            image = {
                doc = {
                    enabled = true,
                    inline = true,
                },
            },
            picker = {
                enabled = false,
            },
        },
        keys = {
            {
                "<leader>k",
                function()
                    Snacks.image.hover()
                end,
                desc = "Image Hover",
            },
        },
    },
}
