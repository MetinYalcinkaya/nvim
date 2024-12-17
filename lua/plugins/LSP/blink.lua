return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "v0.*",
    dependencies = "rafamadriz/friendly-snippets",
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
        list = {
          cycle = { from_top = false },
        },
        menu = {
          border = border("FloatBorder"),
          min_width = 15,
          max_height = 10,
          draw = {
            treesitter = true,
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
        enabled = false,
        window = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = border("FloatBorder"),
        },
      },
      sources = {
        completion = {
          enabled_providers = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "lazydev",
          },
        },
        providers = {
          lsp = {
            fallback_for = { "lazydev" },
            min_keyword_length = 0,
          },
          path = {
            opts = { get_cwd = vim.uv.cwd },
          },
          snippets = {
            friendly_snippets = true,
            min_keyword_length = 0,
            score_offset = -3,
          },
          buffer = {
            fallback_for = { "lsp" },
            min_keyword_length = 4,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
          },
        },
      },
      keymap = {
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up" },
        ["<C-f>"] = { "scroll_documentation_down" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      windows = {
        autocomplete = {
          border = border("FloatBorder"),
          min_width = 10,
          max_height = 10,
        },
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
