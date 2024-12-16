return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "letieu/harpoon-lualine" },
    config = function()
      local harpoon = require("harpoon")
      vim.keymap.set("n", "<Leader>a", function()
        harpoon:list():add()
      end, { desc = "Harpoon Add" })
      vim.keymap.set("n", "<Leader>0", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon UI" })
      vim.keymap.set("n", "<Leader>1", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon 1" })
      vim.keymap.set("n", "<Leader>2", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon 2" })
      vim.keymap.set("n", "<Leader>3", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon 3" })
      vim.keymap.set("n", "<Leader>4", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon 4" })
      harpoon:setup()
    end,
  },
}
