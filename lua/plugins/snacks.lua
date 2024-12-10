return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    --@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        width = 80,
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                btw]],
        },
        sections = {
          { section = "header" },
          {
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            cwd = true,
            limit = 8,
            indent = 2,
            padding = 1,
          },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      notifier = { enabled = true },
      statuscolumn = { enabled = true },
      input = {},
    },
    keys = {
      {
        "<Leader>n",
        function()
          ---@diagnostic disable-next-line: undefined-global
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
    },
  },
}
