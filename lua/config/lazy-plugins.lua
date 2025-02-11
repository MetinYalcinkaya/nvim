require("lazy").setup({
  -- This auto imports all plugins from the given folders, so you don't have to call each plugin individually
  { import = "plugins.LSP" },
  { import = "plugins" },
  { import = "plugins.Notes" },
}, {
  ui = {
    border = border("FloatBorder", "rounded"),
  },
})
