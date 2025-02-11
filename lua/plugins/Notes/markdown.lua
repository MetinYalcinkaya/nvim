return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "gitcommit" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    config = function()
      require("render-markdown").setup({
        debounce = 5,
        win_options = {
          conceallevel = {
            -- These settings work better with obsidian.nvim, instead of
            -- the rendered level of conceallevel=3, it uses 2 which
            -- obsidian.nvim requires, and source mode doesn't conceal
            -- code blocks etc
            default = 0,
            rendered = 2,
          },
        },
      })
      vim.keymap.set("n", "<leader>mt", function()
        require("render-markdown").toggle()
      end, { desc = "Toggle Markdown Render" })
    end,
  },
  -- {
  --   'OXY2DEV/markview.nvim',
  --   ft = 'markdown',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'echasnovski/mini.icons',
  --   },
  --   config = function()
  --     require('markview').setup {
  --       hybrid_modes = { 'n', 'i' },
  --       code_blocks = {
  --         enable = true,
  --         style = 'language',
  --         position = 'overlay',
  --         hl = 'markdownCodeBlock',
  --         language_direction = 'left',
  --         language_names = {
  --           { 'py', 'python' },
  --           { 'cpp', 'c++' },
  --         },
  --       },
  --     }
  --     vim.keymap.set('n', '<leader>mt', '<CMD>Markview toggle<CR>', { desc = 'Toggle Markdown Render' })
  --   end,
  -- },
}
