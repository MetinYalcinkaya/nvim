return {
    {
        "stevearc/oil.nvim",
        lazy = true,
        opts = {
            columns = { "icon", "permissions" },
            view_options = {
                show_hidden = true,
            },
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            use_default_keymaps = false,
            keymaps = {
                ["<CR>"] = "actions.select",
                ["-"] = "actions.parent",
            },
        },
        keys = {
            {
                "<Leader>e",
                function()
                    require("oil").open()
                end,
                desc = "Open Oil",
            },
        },
    },
}
