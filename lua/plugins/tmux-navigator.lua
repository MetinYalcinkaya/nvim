return {
    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            if os.getenv("TMUX") then
                local tmn = require("nvim-tmux-navigation")
                tmn.setup({
                    disable_when_zoomed = true,
                })

                vim.keymap.del("n", "<C-h>")
                vim.keymap.del("n", "<C-j>")
                vim.keymap.del("n", "<C-k>")
                vim.keymap.del("n", "<C-l>")
                vim.keymap.set("n", "<C-h>", tmn.NvimTmuxNavigateLeft, { desc = "Move focus to the left window" })
                vim.keymap.set("n", "<C-j>", tmn.NvimTmuxNavigateDown, { desc = "Move focus to the lower window" })
                vim.keymap.set("n", "<C-k>", tmn.NvimTmuxNavigateUp, { desc = "Move focus to the upper window" })
                vim.keymap.set("n", "<C-l>", tmn.NvimTmuxNavigateRight, { desc = "Move focus to the right window" })
            end
        end,
    },
}
