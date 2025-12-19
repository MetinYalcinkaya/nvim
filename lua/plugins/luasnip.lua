return {
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        build = "make install_jsregexp",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
            local ls = require("luasnip")
            ls.filetype_extend("python", { "pydoc" })
        end,
    },
}
