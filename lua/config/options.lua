-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true

-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more
-- capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Command bar height, when using commands it covers lualine
vim.o.cmdheight = 1

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Chars at end of buffers
vim.opt.fillchars = { eob = " " }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set true term colors
vim.opt.termguicolors = true

-- Disable builtin completion
vim.opt.complete = ""

-- Confirm popup for operations
vim.opt.confirm = true

-- Color column
-- vim.opt.colorcolumn = '80'

-- Change tab sizing
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Disable markdown recommended style
vim.g.markdown_recommended_style = 0

-- Spell language
-- vim.opt.spelllang = { "en_us", "en_au" }
vim.opt.spelllang = "en"

-- Experimental smooth scrolling
vim.opt.smoothscroll = false

-- Conceal level
vim.o.conceallevel = 2

-- Diagnostics disable
-- vim.diagnostic.config({ virtual_text = false })

-- Borders
local border_styles = {
  undefined = nil,
  none = { "", "", "", "", "", "", "", "" },
  double = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
  single = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
  shadow = {
    "",
    "",
    { " ", "FloatShadowThrough" },
    { " ", "FloatShadow" },
    { " ", "FloatShadow" },
    { " ", "FloatShadow" },
    { " ", "FloatShadowThrough" },
    "",
  },
  rounded = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  solid = { " ", " ", " ", " ", " ", " ", " ", " " },
  block = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
  inner_block = { " ", "▄", " ", "▌", " ", "▀", " ", "▐" },
  thinblock = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
  inner_thinblock = { " ", "▁", " ", "▏", " ", "▔", " ", "▕" },
  bullet = { "•", "•", "•", "•", "•", "•", "•", "•" },
  star = { "*", "*", "*", "*", "*", "*", "*", "*" },
  simple = { "+", "-", "+", "|", "+", "-", "+", "|" },
  heavy_single = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
  light_shade = { "░", "░", "░", "░", "░", "░", "░", "░" },
  medium_shade = { "▒", "▒", "▒", "▒", "▒", "▒", "▒", "▒" },
  dark_shade = { "▓", "▓", "▓", "▓", "▓", "▓", "▓", "▓" },
  arrow = { "↗", "→", "↘", "↓", "↙", "←", "↖", "↑" },
  full_block = { "█", "█", "█", "█", "█", "█", "█", "█" },
  diff = {
    { "┌", "DiffText" },
    { "─", "DiffText" },
    { "┐", "DiffText" },
    { "│", "DiffText" },
    { "┘", "DiffText" },
    { "─", "DiffText" },
    { "└", "DiffText" },
    { "│", "DiffText" },
  },
}

_G.border = function(hl_name, style)
  style = style or "rounded"
  local border_def = border_styles[style]

  if not border_def then
    error("Invalid border style: " .. tostring(style))
  end
  local new_border = {}
  for i, element in ipairs(border_def) do
    if type(element) == "table" then
      new_border[i] = { element[1], hl_name or element[2] }
    else
      new_border[i] = { element, hl_name }
    end
  end
  return new_border
  -- return {
  --   { "╭", hl_name },
  --   { "─", hl_name },
  --   { "╮", hl_name },
  --   { "│", hl_name },
  --   { "╯", hl_name },
  --   { "─", hl_name },
  --   { "╰", hl_name },
  --   { "│", hl_name },
  -- }
end
