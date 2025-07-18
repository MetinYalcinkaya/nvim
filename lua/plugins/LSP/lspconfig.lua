return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ui = { border = border("FloatBorder") } },
      },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
      -- { 'j-hui/fidget.nvim', opts = { notification = { override_vim_notify = true } } },
      -- { "j-hui/fidget.nvim" },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
          map("grr", Snacks.picker.lsp_references, "[G]oto [R]eferences")
          map("gri", Snacks.picker.lsp_implementations, "[G]oto [I]mplementation")
          map("grd", Snacks.picker.lsp_definitions, "[G]oto [D]efinition")
          map("grD", Snacks.picker.lsp_declarations, "[G]oto [D]eclaration")
          map("gO", Snacks.picker.lsp_symbols, "Open Document Symbols")
          map("gW", Snacks.picker.lsp_workspace_symbols, "Open Workspace Symbols")
          map("grt", Snacks.picker.lsp_type_definitions, "[G]oto [T]ype Definition")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        -- pylsp = {
        --   settings = {
        --     pylsp = {
        --       plugins = {
        --         pyflakes = { enabled = false },
        --         pycodestyle = { enabled = false },
        --         autopep8 = { enabled = false },
        --         yapf = { enabled = false },
        --         mccabe = { enabled = false },
        --         pylsp_mypy = { enabled = false },
        --         pylsp_black = { enabled = false },
        --         pylsp_isort = { enabled = false },
        --       },
        --     },
        --   },
        -- },
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                typeCheckingMode = "basic",
                diagnosticSeverityOverrides = {
                  reportUnusedImport = false,
                },
              },
            },
          },
        },
        ruff = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.hoverProvider = false
            client.server_capabilities.renameProvider = false
          end,
        },
        marksman = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
        clangd = {
          on_attach = function()
            local clangd_extensions_source_header = require("clangd_extensions.switch_source_header")
            vim.keymap.set(
              "n",
              "<leader>ch",
              clangd_extensions_source_header.switch_source_header,
              { desc = "Switch Source/Header (C/C++)", silent = true }
            )
          end,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style={BasedOnStyle: LLVM, AllowShortFunctionsOnASingleLine: None}",
          },
          filetypes = {
            "c",
            "cpp",
          },
        },
        superhtml = {},
      }

      -- TODO: Find a more graceful way to do this, it's ugly af
      -- but it was the only way to get it done it seems, as
      -- mason-lspconfig doesn't like it when you put
      -- sourcekit through it since it's not officially supported
      -- local swift_server = {
      --   sourcekit = {
      --     root_dir = require("lspconfig").util.root_pattern(".git", "buildServer.json"),
      --   },
      -- }
      --
      -- for server, setup in pairs(swift_server) do
      --   require("lspconfig")[server].setup(setup)
      -- end

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
        -- "black", -- Python formatter
        -- "lua-language-server", -- Lua LSP
        -- "basedpyright", -- Static type checker for Python
        -- "isort", -- Import sorter for Python
        -- "marksman", -- Markdown LSP server (Completion, goto def, references, rename, diag)
        "prettierd", -- Using for markdown formatting specifically
        "clangd", -- C LSP
        -- "clang-format", -- C formatter
        "swiftlint", -- Swift linter
        -- "zls", -- Zig language server
        "ruff", -- Python linter
        -- "pylsp", -- python lsp
      })

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        automatic_enable = {
          exclude = {
            "jdtls",
          },
        },
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
