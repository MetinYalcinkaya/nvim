return {
  {
    'iguanacucumber/magazine.nvim',
    name = 'nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    -- event = 'VeryLazy',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
          },
        },
      },
      'onsails/lspkind.nvim',
      'saadparwaiz1/cmp_luasnip',
      -- 'hrsh7th/cmp-path',
      'FelipeLema/cmp-async-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-calc',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      -- Border icons
      local function border(hl_name)
        return {
          { '╭', hl_name },
          { '─', hl_name },
          { '╮', hl_name },
          { '│', hl_name },
          { '╯', hl_name },
          { '─', hl_name },
          { '╰', hl_name },
          { '│', hl_name },
        }
      end

      luasnip.config.setup {}

      cmp.setup {
        window = {
          completion = {
            border = border 'FloatBorder',
            winhighlight = 'Normal:NormalFloat,CursorLine:PmenuSel,Search:None',
          },
          documentation = {
            border = border 'FloatBorder',
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        performance = {
          debounce = 0,
          throttle = 0,
          fetching_timeout = 500,
          confirm_resolve_timeout = 80,
          async_budget = 1,
          max_view_entries = 200,
          filtering_context_budget = 500,
        },

        formatting = {
          format = lspkind.cmp_format {
            mode = 'text_symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
          },
        },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          {
            name = 'lazydev',
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          -- { name = 'path' },
          { name = 'async_path' },
          { name = 'calc' },
        },
        view = {
          entries = 'custom',
        },
      }

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        -- formatting = { -- removes kind from completion
        --   format = function(entry, vim_item)
        --     vim_item.kind = ''
        --     return vim_item
        --   end,
        -- },
        sources = cmp.config.sources({
          { name = 'async_path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }),
      })
    end,
  },
}
