return {
    {
        "nvim-mini/mini.hipatterns",
        lazy = true,
        opts = {
            hex_color = function()
                require("mini.hipatterns").gen_highlighter.hex_color()
            end,
        },
    },
}
