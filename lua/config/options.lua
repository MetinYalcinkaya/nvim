-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true

-- You can also add relative line numbers, to help with jumping.
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more
-- capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Command bar height, when using commands it covers lualine
vim.o.cmdheight = 1

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Chars at end of buffers
vim.opt.fillchars = { eob = " " }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Set true term colors
vim.o.termguicolors = true

-- Disable builtin completion
vim.o.complete = ""

-- Confirm popup for operations
vim.o.confirm = true

-- Color column
-- vim.o.colorcolumn = "80"

-- Change tab sizing
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true

-- Disable markdown recommended style
vim.g.markdown_recommended_style = 0

-- Spell language
-- vim.o.spelllang = { "en_us", "en_au" }
vim.o.spelllang = "en"

-- Experimental smooth scrolling
vim.o.smoothscroll = false

-- Conceal level
vim.o.conceallevel = 2

-- diagnostic setup
-- vim.diagnostic.config({ signs = false, float = true })
vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    signs = {
        -- gets rid of signs in gutter
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        -- but can color line num
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
        },
    },
    virtual_text = {
        current_line = true,
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
})

-- Borders
vim.o.winborder = "none"

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
