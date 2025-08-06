return {
    {
        "obsidian-nvim/obsidian.nvim",
        -- dir = "~/Developer/obsidian.nvim",
        version = "*",
        -- event = "VeryLazy",
        -- ft = "markdown",
        cond = function()
            local cwd = vim.fn.getcwd()
            local home = vim.fn.expand("~")
            local vault_path = home .. "/Documents/Obsidian/Main"
            return string.find(cwd, vault_path)
        end,
        opts = {
            workspaces = {
                {
                    name = "Main",
                    path = vim.fn.expand("~") .. "/Documents/Obsidian/Main",
                },
            },
            notes_subdir = "inbox",
            new_notes_location = "notes_subdir",
            legacy_commands = false,
            completion = {
                blink = true,
                min_chars = 2,
            },
            disable_frontmatter = true,
            templates = {
                subdir = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
            },
            checkbox = {
                order = {
                    " ",
                    "x",
                },
            },
            ui = {
                enable = true,
                bullets = {},
            },
            attachments = {
                img_folder = "images",
            },
            footer = {
                enabled = false,
            },
        },
        config = function(_, opts)
            local obsidian = require("obsidian")

            obsidian.setup(opts)

            -- vim.keymap.set("n", "<leader>oc", obsidian.util.toggle_checkbox, { desc = "Obsidian Toggle Checkbox" })
            vim.keymap.set(
                "n",
                "<CR>",
                obsidian.api.smart_action,
                { expr = true, buffer = true, desc = "Obsidian Smart Action" }
            )
            vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian open<CR>", { desc = "Open in Obsidian App" })
            vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Show Obsidian Backlinks" })
            vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian links<CR>", { desc = "Show Obsidian Links" })
            vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "Create New Note" })
            vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Search Obsidian" })
            vim.keymap.set("n", "<leader>oq", "<cmd>Obsidian quick_switch<CR>", { desc = "Quick Switch" })
            vim.keymap.set("n", "<leader>op", "<cmd>Obsidian paste_img<CR>", { desc = "Paste Image" })
            vim.keymap.set(
                "n",
                "<leader>ok",
                ":!mv '%:p' ~/Documents/Obsidian/Main/uncategorized<CR>:bd<CR>",
                { desc = "Move File To Uncategorized", silent = true }
            )
            vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<CR>:bd<CR>", { desc = "Delete File", silent = true })

            -- Obsidian specific live grep folders
            local inbox_dir = "~/Documents/Obsidian/Main/inbox"
            local notes_dir = "~/Documents/Obsidian/Main/notes"
            local uncategorized_dir = "~/Documents/Obsidian/Main/uncategorized"

            vim.keymap.set("n", "<leader>sg", function()
                Snacks.picker.grep({ dirs = { inbox_dir, notes_dir, uncategorized_dir } })
            end, { desc = "[S]earch by [G]rep (Obsidian)", noremap = true })
        end,
    },
}
