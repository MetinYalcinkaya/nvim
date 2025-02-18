return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "CodeCompanionChat",
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
        },
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:op read op://API/anthropic/api_key --no-newline",
              },
            })
          end,

          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = "cmd:op read op://API/deepseek/api_key --no-newline",
              },
            })
          end,

          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "cmd:op read op://API/openai/api_key --no-newline",
              },
            })
          end,
        },
      })
    end,
  },
}
