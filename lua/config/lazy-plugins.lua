require("lazy").setup({
    -- This auto imports all plugins from the given folders, so you don't have to call each plugin individually
    { import = "plugins" },
    { import = "plugins.Notes" },
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "rplugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    rocks = {
        enabled = false,
    },
})
