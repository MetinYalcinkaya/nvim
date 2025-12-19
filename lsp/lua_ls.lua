---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            codeLens = { enable = true },
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                disable = { "missing-fields" },
            },
        },
    },
}
