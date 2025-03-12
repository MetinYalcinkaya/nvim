local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking (copying) text
autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
  group = augroup("highlight-on-yank", { clear = true }),
  desc = "Highlight when yanking (copying) text",
})

-- Disables the automatic commenting over the next line when inserting new line (o)
autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = augroup("disable-comment-new-line", { clear = true }),
  desc = "Disable new line comment",
})

-- Spellcheck, wrap, and text width for text filetypes
autocmd("FileType", {
  pattern = { "markdown", "gitcommit", "NeogitCommitMessage", "text" },
  callback = function()
    vim.opt.wrap = true
    vim.opt.spell = true
    vim.opt.textwidth = 80
  end,
  group = augroup("spellcheck-for-md", { clear = true }),
  desc = "Spellcheck for Markdown files",
})

-- Reload on file change
autocmd("FocusGained", {
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  group = augroup("reload-on-file-change", { clear = true }),
  desc = "Reload file if changed",
})

-- Defer friendly-snippets loading and filetype_extend
autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      -- Extending filetypes
      require("luasnip").filetype_extend("python", { "pydoc" })
      require("luasnip").filetype_extend("lua", { "luadoc" })
      -- Loading
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
          vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
        },
      })
    end, 100)
  end,
})

-- Luasnip unlink snippet
-- autocmd("InsertLeave", {
--   callback = function()
--     if
--       require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
--       and not require("luasnip").session.jump_active
--     then
--       require("luasnip").unlink_current()
--     end
--   end,
-- })

-- Snacks disable in ft
vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable snacks.indent for filetype",
  pattern = { "markdown" },
  group = vim.api.nvim_create_augroup("snacks_group", { clear = false }),
  callback = function()
    vim.b.snacks_indent = false
  end,
})

-- Snacks LSP Progress
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    ---@diagnostic disable-next-line
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
