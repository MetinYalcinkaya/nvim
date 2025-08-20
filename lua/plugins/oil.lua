return {
    {
        "stevearc/oil.nvim",
        event = "VeryLazy",
        config = function()
            local oil = require("oil")

            oil.setup({
                columns = { "icon" },
                view_options = {
                    show_hidden = true,
                },
                delete_to_trash = true, -- Deletes to trash
                skip_confirm_for_simple_edits = true,
                use_default_keymaps = false,
                keymaps = {
                    ["<CR>"] = "actions.select",
                    ["-"] = "actions.parent",
                },
            })
            vim.keymap.set("n", "_", require("oil").toggle_float)
        end,
    },
}
