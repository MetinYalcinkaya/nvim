return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "simple",
      options = {
        throttle = 0,
        multilines = {
          enabled = true,
          always_show = true,
        },
      },
    },
  },
}
