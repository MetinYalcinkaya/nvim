local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking (copying) text
autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank { timeout = 200 }
  end,
  group = augroup('highlight-on-yank', { clear = true }),
  desc = 'Highlight when yanking (copying) text',
})

-- Disables the automatic commenting over the next line when inserting new line (o)
autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
  group = augroup('disable-comment-new-line', { clear = true }),
  desc = 'Disable new line comment',
})

-- Spellcheck, wrap, and text width for text filetypes
autocmd('FileType', {
  pattern = { 'markdown', 'gitcommit', 'NeogitCommitMessage' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 80
  end,
  group = augroup('spellcheck-for-md', { clear = true }),
  desc = 'Spellcheck for Markdown files',
})

-- Reload on file change
autocmd('FocusGained', {
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
  group = augroup('reload-on-file-change', { clear = true }),
  desc = 'Reload file if changed',
})

-- Defer friendly-snippets setup to after neovim loads
autocmd('VimEnter', {
  callback = function()
    vim.defer_fn(function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end, 100)
  end,
})

-- Luasnip unlink snippet
autocmd('InsertLeave', {
  callback = function()
    if
      require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end,
})
