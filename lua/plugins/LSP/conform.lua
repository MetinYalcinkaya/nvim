return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = false, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end
      end,
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clangd" },
        css = { "prettierd" },
        go = { "gofmt" },
        html = { "superhtml" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
        rust = { "rustfmt" },
        swift = { "swiftformat" },
      },
    },
  },
}
