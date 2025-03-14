return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 50,
          },
        },
        sections = {
          lualine_a = { { "mode", icon = "" } },
          lualine_b = {
            {
              function() -- Macro recording
                local rr = vim.fn.reg_recording()
                if rr == "" then
                  return ""
                else
                  return "recording @" .. rr
                end
              end,
            },
            { "branch", icon = "" },
          },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              padding = { left = 1, right = 0 },
              file_status = true,
              newfile_status = false,
              path = 1, -- 0: Filename, 1: Relative, 2: Absolute, 3: Absolute w/ ~ for home, 4: Filename, parent
              shorting_target = 40,
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
            },
          },
          lualine_x = {
            { "harpoon2", color_active = { fg = "#ff966c" } },
            {
              "diagnostics",
              always_visible = false,
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = "󰝶 ",
              },
            },
            { "diff" },
          },
          lualine_y = { { "progress" } },
          lualine_z = { { "location" } },
        },
        extensions = { "oil", "mason", "trouble", "lazy" },
      })
    end,
  },
}
