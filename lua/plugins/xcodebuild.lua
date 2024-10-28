return {
  {
    'wojciech-kulik/xcodebuild.nvim',
    ft = 'swift',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
      'stevearc/oil.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local xcodebuild = require 'xcodebuild'
      xcodebuild.setup {
        code_coverage = { enabled = true },
      }
      vim.keymap.set('n', '<leader>X', function()
        require('xcodebuild.actions').show_picker()
      end, { desc = 'Show Xcodebuild Picker' })
    end,
  },
}
