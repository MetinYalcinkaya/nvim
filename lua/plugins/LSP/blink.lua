return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "v0.*",
    dependencies = { "rafamadriz/friendly-snippets", "mikavilpas/blink-ripgrep.nvim" },
    opts = {
      snippets = {
        expand = function(snippet)
          vim.snippet.expand(snippet)
        end,
        active = function(filter)
          return vim.snippet.active(filter)
        end,
        jump = function(direction)
          vim.snippet.jump(direction)
        end,
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
          auto_show_delay_ms = 0,
          update_delay_ms = 0,
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
        enabled = true,
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
            score_offset = 2,
            fallbacks = { "snippets", "buffer" },
            opts = { get_cwd = vim.uv.cwd, show_hidden_files_by_default = true },
          },
          snippets = {
            opts = {
              friendly_snippets = true,
            },
            min_keyword_length = 2,
            score_offset = 9,
          },
          buffer = {
            max_items = 3,
            min_keyword_length = 4,
            score_offset = 1,
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
            score_offset = 8,
          },
        },
      },
      keymap = {
        preset = "none",
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<Up>"] = { "scroll_documentation_up", "fallback" },
        ["<Down>"] = { "scroll_documentation_down", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-Space>"] = { "show_documentation", "hide_documentation" },
      },
      -- windows = {
      --   autocomplete = {
      --     border = border("FloatBorder"),
      --     min_width = 10,
      --     max_height = 10,
      --   },
      -- },
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
