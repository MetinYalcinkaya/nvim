-- clear highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic message" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic message" })
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "Quickfix list" })

-- Rebinds arrowkeys to use hjkl while using Glove80
vim.keymap.set("n", "<Left>", "h", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "j", { noremap = true, silent = true })
vim.keymap.set("n", "<Up>", "k", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "l", { noremap = true, silent = true })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

vim.keymap.set("n", "<C-Left>", "<C-h>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-Down>", "<C-j>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-Up>", "<C-k>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-Right>", "<C-l>", { noremap = false, silent = true })

-- Remove
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")

-- Fzf
vim.keymap.set("n", "<Leader>fB", "<CMD>FzfLua buffers<CR>", { desc = "Buffers" })
vim.keymap.set("n", "<Leader>fc", function()
    require("fzf-lua").files({ cwd = vim.fn.stdpath("config"), winopts = { title = " Config " } })
end, { desc = "Config" })
vim.keymap.set("n", "<Leader>ff", function()
    require("fzf-lua-frecency").frecency({
        display_score = false,
        cwd_only = true,
        fzf_opts = { ["--no-sort"] = false },
    })
end, { desc = "Find files" })
vim.keymap.set("n", "<Leader>fd", "<CMD>FzfLua lsp_document_diagnostics<CR>", { desc = "Document diagnostics" })
vim.keymap.set("n", "<Leader>fg", "<CMD>FzfLua live_grep<CR>", { desc = "Grep" })
vim.keymap.set("x", "<Leader>fg", "<CMD>FzfLua grep_visual<CR>", { desc = "Grep" })
vim.keymap.set("n", "<Leader>fh", "<CMD>FzfLua helptags<CR>", { desc = "Help" })
vim.keymap.set("n", "<Leader>fo", "<CMD>FzfLua oldfiles<CR>", { desc = "Oldfiles" })
vim.keymap.set("n", "<Leader>fu", "<CMD>FzfLua undotree<CR>", { desc = "Undotree" })
vim.keymap.set("n", "<Leader>f<", "<CMD>FzfLua resume<CR>", { desc = "Resume fzf" })
vim.keymap.set("n", "z=", "<CMD>FzfLua spell_suggest<CR>", { desc = "Spelling suggestions" })
vim.keymap.set({ "n", "x" }, "<Leader>fb", function()
    local opts = {
        winopts = {
            preview = { vertical = "down:70%" },
            treesitter = {
                enabled = false,
                fzf_colors = { ["fg"] = { "fg", "CursorLine" }, ["bg"] = { "bg", "Normal" } },
            },
        },
        fzf_opts = {
            ["--layout"] = "reverse",
        },
    }
    local mode = vim.api.nvim_get_mode().mode
    if vim.startswith(mode, "n") then
        require("fzf-lua").lgrep_curbuf(opts)
    else
        require("fzf-lua").blines(opts)
    end
end, { desc = "Search current buffer" })

-- Conform
vim.keymap.set("", "<Leader>fm", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
