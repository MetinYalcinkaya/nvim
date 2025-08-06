return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            delay = 0,
            icons = {
                keys = {
                    BS = "󰭜 ", -- Better backspace icon + fix space issue I had
                },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.add({
                -- { "<Leader>c", group = "[C]ode", icon = { icon = "", color = "orange" }, mode = { "n", "x" } },
                -- { "<Leader>d", group = "[D]ocument", icon = { icon = "󰈔", color = "cyan" } },
                -- { "<Leader>r", group = "[R]ename", icon = { icon = "󰘎", color = "cyan" } },
                { "<Leader>s", group = "[S]earch", icon = { icon = "", color = "green" } },
                { "<Leader>t", group = "[T]oggle", icon = { icon = "", color = "yellow" } },
                -- Obsidian/Markdown
                { "<Leader>o", group = "[O]bsidian", icon = { icon = "", color = "purple" } },
                { "<Leader>m", group = "[M]arkdown", icon = { icon = "", color = "purple" } },
                -- Oil.nvim icon
                { "_", group = "Oil Overlay", icon = { icon = "󰏇", color = "red" } },
                -- Trouble
                { "<Leader>x", group = "Diagnostics", icon = { icon = "󰔫", color = "cyan" } },
                -- Git
                { "<Leader>g", group = "[G]it", icon = { name = "git", cat = "filetype" } },
                { "<Leader>g", desc = "[G]it", mode = "v" },
                { "<Leader>gh", desc = "[H]unk", icon = { name = "git", cat = "filetype" } },
                { "<Leader>gt", desc = "[T]oggle", icon = { name = "git", cat = "filetype" } },
                { "<Leader>gv", desc = "Diff[v]iew", icon = { name = "git", cat = "filetype" } },
                -- Harpoon
                { "<Leader>h", group = "[H]arpoon", icon = { icon = "󰀱", color = "grey" } },
                { "<Leader>1", group = "Harpoon 1", icon = { icon = "󰀱", color = "grey" } },
                { "<Leader>2", group = "Harpoon 2", icon = { icon = "󰀱", color = "grey" } },
                { "<Leader>3", group = "Harpoon 3", icon = { icon = "󰀱", color = "grey" } },
                { "<Leader>4", group = "Harpoon 4", icon = { icon = "󰀱", color = "grey" } },
                { "<Leader>5", group = "Harpoon 5", icon = { icon = "󰀱", color = "grey" } },
                -- Find Files
                { "<Leader>f", desc = "[F]ind", icon = { icon = "", color = "cyan" } },
                -- Snacks
                { "<Leader>u", desc = "Misc", icon = { icon = "", color = "grey" } },
                -- Hidden keymaps
                wk.setup(opts),
            })
        end,
    },
}
