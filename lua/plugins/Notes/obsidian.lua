return {
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    cond = function()
      local cwd = vim.fn.getcwd()
      local home = vim.fn.expand '~'
      local vault_path = home .. '/Documents/Obsidian/Main'
      return string.find(cwd, vault_path) -- cwd == vault_path
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'Main',
          path = '~/Documents/Obsidian/Main/',
        },
      },
      notes_subdir = 'inbox',
      new_notes_location = 'notes_subdir',

      completion = {
        nvim_cmp = true,
        min_chars = 0,
      },
      mappings = {
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      disable_frontmatter = false,
      templates = {
        subdir = 'templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
      },
      ui = {
        enable = true,
        checkboxes = {},
        bullets = {},
      },
      attachments = {
        img_folder = 'images',
      },
    },
    config = function(_, opts)
      local obsidian = require 'obsidian'

      obsidian.setup(opts)

      vim.keymap.set('n', '<leader>oc', obsidian.util.toggle_checkbox, { desc = 'Obsidian Toggle Checkbox' })
      vim.keymap.set('n', '<leader>oo', '<cmd>ObsidianOpen<CR>', { desc = 'Open in Obsidian App' })
      vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<CR>', { desc = 'Show Obsidian Backlinks' })
      vim.keymap.set('n', '<leader>ol', '<cmd>ObsidianLinks<CR>', { desc = 'Show Obsidian Links' })
      vim.keymap.set('n', '<leader>on', '<cmd>ObsidianNew<CR>', { desc = 'Create New Note' })
      vim.keymap.set('n', '<leader>os', '<cmd>ObsidianSearch<CR>', { desc = 'Search Obsidian' })
      vim.keymap.set('n', '<leader>oq', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Quick Switch' })
      vim.keymap.set('n', '<leader>op', '<cmd>ObsidianPasteImg<CR>', { desc = 'Paste Image' })
      vim.keymap.set(
        'n',
        '<leader>ok',
        ":!mv '%:p' ~/Documents/Obsidian/Main/uncategorized<CR>:bd<CR>",
        { desc = 'Move File To Uncategorized', silent = true }
      )
      vim.keymap.set('n', '<leader>odd', ":!rm '%:p'<CR>:bd<CR>", { desc = 'Delete File', silent = true })

      -- Inserts template and formats first title by removing date and file name chars
      vim.keymap.set('n', '<leader>ot', function()
        vim.cmd 'ObsidianTemplate note'
        local LINE_NUM = 13
        local line = vim.fn.getline(LINE_NUM)
        local title = line:match '# (.*)'

        if title then
          title = title:gsub('_%d%d%d%d%-%d%d%-%d%d$', '')
          title = title:gsub('[_%-]', ' ')
          title = title:gsub('%s+$', '')
          vim.fn.setline(LINE_NUM, '# ' .. title)
        end

        vim.cmd 'noh'
      end, { desc = 'Insert Template' })

      -- Obsidian specific live grep folders
      local inbox_dir = '~/Documents/Obsidian/Main/inbox'
      local notes_dir = '~/Documents/Obsidian/Main/notes'
      local uncategorized_dir = '~/Documents/Obsidian/Main/uncategorized'

      vim.keymap.set('n', '<leader>sg', function()
        require('telescope.builtin').live_grep { search_dirs = { inbox_dir, notes_dir, uncategorized_dir } }
      end, { desc = '[S]earch by [G]rep (Obsidian)' })
    end,
  },
}
