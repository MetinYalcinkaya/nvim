return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
    keys = {
      { "<leader>gds", "<CMD>DiffviewOpen<CR>", desc = "Show", silent = true },
      { "<leader>gdc", "<CMD>DiffviewClose<CR>", desc = "Close", silent = true },
    },
  },
}
