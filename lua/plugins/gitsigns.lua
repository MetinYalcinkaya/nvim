return {
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.jobstart({ "git", "-C", vim.fn.expand("%:h"), "rev-parse" }, {
                        on_exit = function(_, return_code)
                            if return_code == 0 then
                                vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
                                vim.schedule(function()
                                    require("lazy").load({ plugins = { "gitsigns.nvim" } })
                                end)
                            end
                        end,
                    })
                end,
            })
        end,
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
                map("v", "<Leader>ghs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "[G]it [S]tage Hunk" })
                map("v", "<Leader>ghr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "[G]it [R]eset Hunk" })
                -- Normal
                map("n", "<Leader>ghs", gitsigns.stage_hunk, { desc = "[s]tage hunk" })
                map("n", "<Leader>ghr", gitsigns.reset_hunk, { desc = "[r]eset hunk" })
                map("n", "<Leader>ghS", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
                -- map("n", "<Leader>ghu", gitsigns.undo_stage_hunk, { desc = "Git [u]ndo stage hunk" })
                map("n", "<Leader>ghR", gitsigns.reset_buffer, { desc = "[R]eset buffer" })
                map("n", "<Leader>ghp", gitsigns.preview_hunk, { desc = "[p]review hunk" })
                map("n", "<Leader>ghb", gitsigns.blame_line, { desc = "[b]lame line" })
                map("n", "<Leader>ghd", gitsigns.diffthis, { desc = "[d]iff against index" })
                map("n", "<Leader>ghD", function()
                    gitsigns.diffthis("@")
                end, { desc = "[D]iff against last commit" })
                -- Toggles
                map("n", "<Leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Show [b]lame line" })
                map("n", "<Leader>gtd", gitsigns.preview_hunk_inline, { desc = "Show [D]eleted" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        },
    },
}
