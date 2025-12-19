return {
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "nvim-mini/mini.icons",
        },
        cmd = { "FzfLua" },
        opts = function()
            local fzf = require("fzf-lua")
            local config = fzf.config
            local actions = fzf.actions

            config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
            config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
            config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
            config.defaults.keymap.fzf["ctrl-x"] = "jump"
            config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
            config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
            config.defaults.keymap.builtin["ctrl-f"] = "preview-page-down"
            config.defaults.keymap.builtin["ctrl-b"] = "preview-page-up"
            config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open

            -- toggle root dir/cwd
            local function root(bufnr)
                bufnr = bufnr or 0
                local r = vim.fs.root(bufnr, { ".git", "Cargo.toml", "pyproject.toml" })
                return r or vim.uv.cwd()
            end

            local function toggle_root(_, ctx)
                local o = vim.deepcopy(ctx.__call_opts or {})
                local bufnr = (ctx.__CTX and ctx.__CTX.bufnr) or 0
                local r, c = root(bufnr), vim.uv.cwd()
                o.cwd = (o.cwd == r) and c or r
                o.buf = bufnr

                local cmd = (ctx.__INFO and ctx.__INFO.cmd) or "files"
                if o.resume then
                    fzf.resume(o)
                else
                    fzf[cmd](o)
                end
            end

            config.defaults.actions.files["ctrl-r"] = toggle_root
            config.set_action_helpstr(toggle_root, "toggle-root-dir")

            return {
                { "border-fused", "hide" },
                fzf_colors = {
                    bg = { "bg", "Normal" },
                    gutter = { "bg", "Normal" },
                    info = { "fg", "Conditional" },
                    scrollbar = { "bg", "Normal" },
                    separator = { "fg", "Comment" },
                },
                fzf_opts = {
                    ["--info"] = "inline-right",
                    ["--layout"] = "reverse",
                },
                keymap = {
                    builtin = {
                        ["<C-?>"] = "toggle-help",
                        ["<C-a>"] = "toggle-fullscreen",
                        ["<C-i>"] = "toggle-preview",
                    },
                    fzf = {
                        ["alt-s"] = "toggle",
                        ["alt-a"] = "toggle-all",
                        ["ctrl-i"] = "toggle-preview",
                    },
                },
                winopts = {
                    preview = {
                        scrollbar = false,
                        layout = "vertical",
                        vertical = "down:40%",
                    },
                },
                defaults = {
                    git_icons = false,
                },
                previewers = {
                    codeaction = {
                        toggle_behavior = "extend",
                    },
                },
                files = {
                    winopts = {
                        preview = {
                            hidden = true,
                        },
                    },
                },
                grep = {
                    hidden = true,
                    rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g '!.git' -e",
                    rg_glob_fn = function(q, opts)
                        local regex, flags = q:match(string.format("^(.*)%s(.*)$", opts.glob_separator))
                        return (regex or q), flags
                    end,
                },
                helptags = {
                    actions = {
                        ["enter"] = actions.help,
                    },
                },
                lsp = {
                    code_actions = {
                        winopts = {
                            width = 70,
                            height = 20,
                            relative = "cursor",
                            preview = {
                                hidden = true,
                                vertical = "down:50%",
                            },
                        },
                    },
                },
                diagnostics = {
                    multiline = 1,
                    actions = {
                        ["ctrl-e"] = {
                            fn = function(_, opts)
                                if opts.severity_only then
                                    opts.severity_only = nil
                                else
                                    opts.severity_only = vim.diagnostic.severity.ERROR
                                end
                                require("fzf-lua").resume(opts)
                            end,
                            noclose = true,
                            desc = "toggle-all-only-errors",
                            header = function(opts)
                                return opts.severity_only and "show all" or "show only errors"
                            end,
                        },
                    },
                },
                oldfiles = {
                    include_current_session = true,
                    winopts = {
                        preview = {
                            hidden = true,
                        },
                    },
                },
            }
        end,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(items, opts, on_choice)
                local ui_select = require("fzf-lua.providers.ui_select")
                if not ui_select.is_registered() then
                    ui_select.register(function(ui_opts)
                        ui_opts.winopts = { height = 0.8, width = 0.6 }

                        if ui_opts.kind then
                            ui_opts.winopts.title = string.format(" %s ", ui_opts.kind)
                        end

                        if ui_opts.prompt and not vim.endswith(ui_opts.prompt, " ") then
                            ui_opts.prompt = ui_opts.prompt .. " "

                            return ui_opts
                        end
                    end)

                    if #items > 0 then
                        return vim.ui.select(items, opts, on_choice)
                    end
                end
            end
        end,
    },
}
