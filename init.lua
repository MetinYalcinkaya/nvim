vim.loader.enable()
require("config/options")
require("config/keymaps")
require("config/autocommands")
require("config/lazy-bootstrap")
require("config/lazy-plugins")

-- TODO: builtin lsp enable

-- local lsp_configs = {}
--
-- for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
--   local server_name = vim.fn.fnamemodify(f, ":t:r")
--   table.insert(lsp_configs, server_name)
-- end
-- vim.lsp.enable(lsp_configs)
