return {
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end, { desc = "Jump to next git [c]hange" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end, { desc = "Jump to previous git [c]hange" })

                -- Actions
                -- Visual
                map("v", "<leader>ghs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "[G]it [S]tage Hunk" })
                map("v", "<leader>ghr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "[G]it [R]eset Hunk" })
                -- Normal
                map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "[s]tage hunk" })
                map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "[r]eset hunk" })
                map("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
                -- map("n", "<leader>ghu", gitsigns.undo_stage_hunk, { desc = "Git [u]ndo stage hunk" })
                map("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "[R]eset buffer" })
                map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "[p]review hunk" })
                map("n", "<leader>ghb", gitsigns.blame_line, { desc = "[b]lame line" })
                map("n", "<leader>ghd", gitsigns.diffthis, { desc = "[d]iff against index" })
                map("n", "<leader>ghD", function()
                    gitsigns.diffthis("@")
                end, { desc = "[D]iff against last commit" })
                -- Toggles
                map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Show [b]lame line" })
                map("n", "<leader>gtd", gitsigns.preview_hunk_inline, { desc = "Show [D]eleted" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        },
    },
}
