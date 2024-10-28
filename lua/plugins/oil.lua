return {
  {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    config = function()
      local oil = require 'oil'

      -- Opens current directory of oil in a new tmux pane
      local function open_tmux_pane_to_directory(direction)
        local cwd = oil.get_current_dir()
        if not cwd then
          vim.notify('Could not retrieve the current directory from oil.nvim', vim.log.levels.ERROR)
          return
        end

        local escaped_cwd = vim.fn.shellescape(cwd)
        local tmux_cmd = string.format('tmux split-window -%s -c %s', direction, escaped_cwd)
        os.execute(tmux_cmd)
      end

      -- Opens file under cursor in a new tmux pane
      local function open_tmux_pane_to_file_in_neovim(direction)
        local cwd = oil.get_current_dir()
        if not cwd then
          vim.notify('Could not retrieve the current directory from oil.nvim', vim.log.levels.ERROR)
          return
        end
        local cursor_entry = oil.get_cursor_entry()
        if not cursor_entry then
          vim.notify('Could not retrieve the file under cursor from oil.nvim', vim.log.levels.ERROR)
          return
        end

        local escaped_cwd = vim.fn.shellescape(cwd)
        local tmux_cmd =
          string.format('tmux split-window -%s -c %s "nvim %s"', direction, escaped_cwd, cursor_entry.name)
        os.execute(tmux_cmd)
      end

      oil.setup {
        columns = { 'icon' },
        view_options = {
          show_hidden = true,
        },
        delete_to_trash = true, -- Deletes to trash
        skip_confirm_for_simple_edits = true,
        use_default_keymaps = false,
        keymaps = {
          ['<CR>'] = 'actions.select',
          ['-'] = 'actions.parent',
          ['<C-o>'] = function()
            open_tmux_pane_to_directory 'h'
            oil.toggle_float()
          end,
          ['<Leader>o'] = function()
            open_tmux_pane_to_file_in_neovim 'h'
            oil.toggle_float()
          end,
        },
      }
      vim.keymap.set('n', '_', require('oil').toggle_float)
    end,
  },
}
