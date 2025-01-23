return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 0,
      icons = {
        keys = {
          BS = "󰭜 ", -- Better backspace icon + fix space issue I had
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.add({
        { "<leader>c", group = "[C]ode", icon = { icon = "", color = "orange" }, mode = { "n", "x" } },
        { "<leader>d", group = "[D]ocument", icon = { icon = "󰈔", color = "cyan" } },
        { "<leader>r", group = "[R]ename", icon = "󰘎" },
        { "<leader>s", group = "[S]earch", icon = { icon = "", color = "green" } },
        { "<leader>t", group = "[T]oggle", icon = { icon = "", color = "yellow" } },
        { "<leader>w", group = "[W]orkspace", icon = "" },
        -- Obsidian/Markdown
        { "<leader>o", group = "[O]bsidian", icon = { icon = "", color = "purple" } },
        { "<leader>m", group = "[M]arkdown", icon = "" },
        -- Oil.nvim icon
        { "<leader>-", group = "Oil Overlay", icon = { icon = "󰏇", color = "red" } },
        -- Surround
        { "s", group = "+ surround", icon = { icon = "󰅪", color = "cyan" } },
        -- Trouble
        { "<leader>x", group = "Diagnostics", icon = { icon = "󰔫", color = "cyan" } },
        -- Git
        { "<leader>g", group = "[G]it", icon = { name = "git", cat = "filetype" } },
        { "<leader>g", desc = "[G]it", mode = "v" },
        { "<leader>gh", desc = "[H]unk", icon = { name = "git", cat = "filetype" } },
        { "<leader>gt", desc = "[T]oggle", icon = { name = "git", cat = "filetype" } },
        { "<leader>gd", desc = "[D]iffview", icon = { name = "git", cat = "filetype" } },
        -- Harpoon
        { "<leader>h", group = "[H]arpoon", icon = "󰀱" },
        { "<Leader>1", group = "Harpoon 1", icon = "󰀱" },
        { "<Leader>2", group = "Harpoon 2", icon = "󰀱" },
        { "<Leader>3", group = "Harpoon 3", icon = "󰀱" },
        { "<Leader>4", group = "Harpoon 4", icon = "󰀱" },
        { "<Leader>5", group = "Harpoon 5", icon = "󰀱" },
        wk.setup(opts),
      })
    end,
  },
}
