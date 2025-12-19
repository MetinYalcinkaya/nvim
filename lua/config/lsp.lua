local M = {}

vim.g.inlay_hints = false

local function on_attach(client, bufnr)
    local function map(keys, func, opts, mode)
        mode = mode or "n"
        opts = type(opts) == "string" and { desc = opts } or opts
        opts.buffer = bufnr
        vim.keymap.set(mode, keys, func, opts)
    end

    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
    map("grr", function()
        require("fzf-lua").lsp_references()
    end, "References")
    map("gri", function()
        require("fzf-lua").lsp_implementations()
    end, "Implementations")
    map("grd", function()
        require("fzf-lua").lsp_definitions()
    end, "Definitions")
    map("grD", function()
        require("fzf-lua").lsp_declarations()
    end, "Declarations")
    map("gO", function()
        require("fzf-lua").lsp_document_symbols()
    end, "Document Symbols")
    map("gW", function()
        require("fzf-lua").lsp_workspace_symbols()
    end, "Workspace Symbols")
    map("grt", function()
        require("fzf-lua").lsp_typedefs()
    end, "Type Definitions")

    if client:supports_method("textDocument/documentHighlight") then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
            desc = "Highlight references under cursor",
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
            desc = "Clear highlight references",
        })
    end

    if client:supports_method("textDocument/inlayHint") then
        local inlay_hints_group = vim.api.nvim_create_augroup("inlay-hints", { clear = false })

        if vim.g.inlay_hints then
            vim.defer_fn(function()
                local mode = vim.api.nvim_get_mode().mode
                vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr })
            end, 500)
        end

        vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = bufnr,
            group = inlay_hints_group,
            callback = function()
                if vim.g.inlay_hints then
                    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                end
            end,
            desc = "Enable inlay hints",
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            buffer = bufnr,
            group = inlay_hints_group,
            callback = function()
                if vim.g.inlay_hints then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
            end,
            desc = "Disable inlay hints",
        })

        map("<Leader>th", function()
            local mode = vim.api.nvim_get_mode().mode
            vim.g.inlay_hints = not vim.g.inlay_hints
            vim.lsp.inlay_hint.enable(vim.g.inlay_hints and (mode == "n" or mode == "v"))
        end, "Toggle Inlay Hints")
    end
end

local register_capability = vim.lsp.handlers["client/registerCapability"]
vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
        return
    end
    on_attach(client, vim.api.nvim_get_current_buf())
    return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
    desc = "Configure LSP keymaps",
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
        local servers = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ":t:r")
            end)
            :totable()
        vim.lsp.enable(servers)
    end,
    desc = "Set up LSP servers",
})

return M
