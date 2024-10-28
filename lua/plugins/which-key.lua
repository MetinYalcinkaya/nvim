return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'modern',
      icons = {
        keys = {
          BS = '󰭜 ', -- Better backspace icon + fix space issue I had
        },
      },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.add {
        { '<leader>c', group = '[C]ode', icon = { icon = '', color = 'orange' }, mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument', icon = { icon = '󰈔', color = 'cyan' } },
        { '<leader>h', group = 'Git [H]unk' },
        { '<leader>r', group = '[R]ename', icon = '󰘎' },
        { '<leader>s', group = '[S]earch', icon = { icon = '', color = 'green' } },
        { '<leader>t', group = '[T]oggle', icon = { icon = '', color = 'yellow' } },
        { '<leader>w', group = '[W]orkspace', icon = '' },
        { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
        -- Obsidian/Markdown
        { '<leader>o', group = '[O]bsidian', icon = { icon = '', color = 'purple' } },
        { '<leader>m', group = '[M]arkdown', icon = '' },
        -- Oil.nvim icon
        { '<leader>-', group = 'Oil Overlay', icon = { icon = '󰏇', color = 'red' } },
        -- Surround
        { 's', group = '+ surround', icon = { icon = '󰅪', color = 'cyan' } },
        -- Trouble
        { '<leader>x', group = 'Diagnostics', icon = { icon = '󰔫', color = 'cyan' } },
        -- Git
        { '<leader>g', group = '[G]it', icon = { name = 'git', cat = 'filetype' } },
        wk.setup(opts),
      }
    end,
  },
}
