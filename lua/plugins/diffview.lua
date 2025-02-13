return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
    keys = {
      { "<leader>gvs", "<CMD>DiffviewOpen<CR>", desc = "Show", silent = true },
      { "<leader>gvc", "<CMD>DiffviewClose<CR>", desc = "Close", silent = true },
    },
  },
}
