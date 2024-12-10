-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Move visual code up/down
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move code down", silent = true })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move code up", silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- NOTE: This doesn't seem to work in tmux, maybe find alternative
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Rebinds arrowkeys to use hjkl while using Glove80
vim.api.nvim_set_keymap("n", "<Left>", "h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", "j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Up>", "k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", "l", { noremap = true, silent = true })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

vim.api.nvim_set_keymap("n", "<C-Left>", "<C-h>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-j>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-k>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-l>", { noremap = false, silent = true })
