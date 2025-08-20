return {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    opts = {
        dependencies_bin = {
            ["tinymist"] = "tinymist",
        },
    },
    config = function()
        local typst = require("typst-preview")
        typst.setup({
            dependencies_bin = {
                ["tinymist"] = "tinymist",
            },
        })
        vim.keymap.set("n", "<Leader>p", "<CMD>TypstPreview<CR>", { silent = true })
    end,
}
