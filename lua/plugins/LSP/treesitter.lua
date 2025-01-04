return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- build = ":TSUpdate",
    -- main = "nvim-treesitter.configs",
    branch = "main",
    -- opts = {
    --   -- ensure_installed = {
    --   --   "bash",
    --   --   "c",
    --   --   "cmake",
    --   --   "cpp",
    --   --   "go",
    --   --   "html",
    --   --   "lua",
    --   --   "luadoc",
    --   --   "make",
    --   --   "markdown",
    --   --   "markdown_inline",
    --   --   "python",
    --   --   "regex",
    --   --   "rust",
    --   --   "sql",
    --   --   "swift",
    --   --   "vim",
    --   --   "vimdoc",
    --   -- },
    --   -- auto_install = true,
    --   highlight = {
    --     enable = true,
    --     -- disable = { "swift" }, -- Not sure why, but performs terribly with swift
    --     -- additional_vim_regex_highlighting = { "ruby" },
    --   },
    --   -- indent = { enable = false, disable = { "ruby" } },
    -- },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          -- if args.match == 'asl' and api.nvim_buf_line_count(args.buf) > 40000 then
          if args.match == "asl" then
            return
          end
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end

          vim.api.nvim_exec_autocmds("User", { pattern = "ts_attach" })
        end,
      })
      require("nvim-treesitter").setup({
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    "lewis6991/ts-install.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    run = ":TS update",
    config = function()
      require("ts-install").setup({
        auto_install = true,
      })
    end,
  },
}
