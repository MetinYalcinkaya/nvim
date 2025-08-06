return {
    {
        "saghen/blink.cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        -- version = "v0.*",
        build = "cargo build --release",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
                dependencies = "rafamadriz/friendly-snippets",
                config = function()
                    local ls = require("luasnip")
                    ls.filetype_extend("python", { "pydoc" })
                end,
            },
            "mikavilpas/blink-ripgrep.nvim",
        },
        opts = {
            snippets = {
                preset = "luasnip",
                -- expand = function(snippet)
                --   vim.snippet.expand(snippet)
                -- end,
                -- active = function(filter)
                --   return vim.snippet.active(filter)
                -- end,
                -- jump = function(direction)
                --   vim.snippet.jump(direction)
                -- end,
                -- expand = function(snippet)
                --   require("luasnip").lsp_expand(snippet)
                -- end,
                -- active = function(filter)
                --   if filter and filter.direction then
                --     return require("luasnip").jumpable(filter.direction)
                --   end
                --   return require("luasnip").in_snippet()
                -- end,
                -- jump = function(direction)
                --   require("luasnip").jump(direction)
                -- end,
            },
            cmdline = {
                completion = {
                    ghost_text = {
                        enabled = false,
                    },
                    menu = {
                        auto_show = function()
                            return vim.fn.getcmdtype() == ":"
                        end,
                    },
                },
            },
            completion = {
                menu = {
                    border = border("FloatBorder"),
                    min_width = 15,
                    max_height = 10,
                    draw = {
                        treesitter = { "lsp" },
                        columns = { { "label", "label_description", gap = 1 }, { "kind", "kind_icon", gap = 1 } },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 50,
                    update_delay_ms = 50,
                    window = {
                        min_width = 10,
                        max_width = 60,
                        max_height = 20,
                        border = border("FloatBorder"),
                    },
                },
                ghost_text = {
                    enabled = false,
                },
            },
            signature = {
                enabled = false,
                window = {
                    show_documentation = false,
                    min_width = 1,
                    max_width = 100,
                    max_height = 10,
                    border = border("FloatBorder"),
                },
            },
            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                    "lazydev",
                    "ripgrep",
                },
                providers = {
                    lsp = {
                        fallbacks = { "ripgrep" },
                        score_offset = 10,
                    },
                    path = {
                        score_offset = 5,
                        fallbacks = { "snippets", "buffer" },
                        opts = { get_cwd = vim.uv.cwd, show_hidden_files_by_default = true },
                    },
                    snippets = {
                        -- FIX: docstrings ain't workin'
                        min_keyword_length = 1,
                        score_offset = 8,
                    },
                    buffer = {
                        max_items = 3,
                        min_keyword_length = 4,
                        score_offset = 5,
                    },
                    lazydev = {
                        name = "LazyDev",
                        fallbacks = { "lsp" },
                        module = "lazydev.integrations.blink",
                        score_offset = 10,
                    },
                    ripgrep = {
                        module = "blink-ripgrep",
                        name = "Ripgrep",
                        min_keyword_length = 1,
                        score_offset = 5,
                    },
                },
            },
            keymap = {
                preset = "none",
                ["<C-n>"] = { "select_next", "fallback_to_mappings" },
                ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
                ["<Up>"] = { "scroll_documentation_up", "fallback" },
                ["<Down>"] = { "scroll_documentation_down", "fallback" },
                ["<C-y>"] = { "select_and_accept", "fallback" },
                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            },
            -- windows = {
            --   autocomplete = {
            --     border = border("FloatBorder"),
            --     min_width = 10,
            --     max_height = 10,
            --   },
            -- },
            fuzzy = {
                implementation = "rust",
            },
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
                kind_icons = {
                    Text = "󰉿",
                    Method = "󰊕",
                    Function = "󰊕",
                    Constructor = "󰒓",

                    Field = "󰜢",
                    Variable = "󰆦",
                    Property = "󰖷",

                    Class = "󱡠",
                    Interface = "󱡠",
                    Struct = "󱡠",
                    Module = "󰅩",

                    Unit = "󰪚",
                    Value = "󰦨",
                    Enum = "󰦨",
                    EnumMember = "󰦨",

                    Keyword = "󰻾",
                    Constant = "󰏿",

                    Snippet = "󱄽",
                    Color = "󰏘",
                    File = "󰈔",
                    Reference = "󰬲",
                    Folder = "󰉋",
                    Event = "󱐋",
                    Operator = "󰪚",
                    TypeParameter = "󰬛",
                },
            },
        },
    },
}
