return {
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   config = function()
  --     require('catppuccin').setup {
  --       flavour = 'mocha',
  --       transparent_background = true,
  --       integrations = {
  --         noice = true,
  --         notify = true,
  --         fidget = true,
  --         diffview = true,
  --         mason = true,
  --         indent_blankline = {
  --           enabled = true,
  --           scope_color = 'lavender',
  --           colored_indent_levels = true,
  --         },
  --         telescope = {
  --           enabled = true,
  --         },
  --       },
  --     }
  --     vim.cmd.colorscheme 'catppuccin'
  --   end,
  -- },
  {
    "rose-pine/neovim",
    dir = "~/Developer/rose-pine/neovim/",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main",
        styles = {
          transparency = true,
        },
      })
      vim.cmd.colorscheme("rose-pine")
    end,
  },
}
