return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
    keys = {
      { "<leader>gd", "<CMD>DiffviewOpen<CR>", desc = "DiffView", silent = true },
      { "<leader>gc", "<CMD>DiffviewClose<CR>", desc = "DiffView Close", silent = true },
    },
  },
}
