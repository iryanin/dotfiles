local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Appearence
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    which_key = true,
                    notify = true,
                    mini = false,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { 'famiu/bufdelete.nvim' },
        config = function()
            local bufferline = require("bufferline")
            bufferline.setup({
                options = {
                    close_command = "Bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
                    right_mouse_command = "Bdelete! %d", -- can be a string | function | false, see "Mouse actions"
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            text_align = "center",
                        },
                    },
                    diagnostics = "nvim_lsp",
                    ---@diagnostic disable-next-line: unused-local
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local s = " "
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " " or (e == "warning" and " " or " ")
                            s = s .. n .. sym
                        end
                        return s
                    end,
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local lualine = require("lualine")
            lualine.setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = { "alpha" },
                        winbar = { "alpha" },
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = { "nvim-tree", "nvim-dap-ui", "toggleterm", "symbols-outline", "lazy" },
            })
        end,
    },
    {
        "goolord/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }
            dashboard.section.buttons.val = {
                dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("p", "󰉋  Find project", ":Telescope projects <CR>"),
                dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
                dashboard.button("t", "󰦨  Find text", ":Telescope live_grep <CR>"),
                dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
            }

            local function footer()
                return "Take the hits, lick our wounds, and move on."
            end

            dashboard.section.footer.val = footer()

            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "Include"
            dashboard.section.buttons.opts.hl = "Keyword"

            dashboard.opts.opts.noautocmd = true
            alpha.setup(dashboard.opts)
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            -- This module contains a number of default definitions
            local rainbow_delimiters = require("rainbow-delimiters")

            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    vim = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                priority = {
                    [''] = 110,
                    lua = 210,
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end,
    },
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup({
                exclude_filetypes = { "toggleterm" },
            })
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({})
        end,
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },

    -- Insert Enhance
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    -- Lsp Utility
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "onsails/lspkind.nvim",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local compare = require("cmp.config.compare")
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            lspkind.init({
                symbol_map = {
                    -- Copilot = "",
                },
            })

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        compare.offset,
                        compare.exact,
                        compare.score,
                        compare.recently_used,
                        compare.kind,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    },
                },
                -- window = {
                --     completion = {
                --         winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                --         -- col_offset = -3,
                --         side_padding = 0,
                --     },
                -- },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        menu = {
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            path = "[Path]",
                            cmdline = "[Command]",
                        },
                    }),
                },
                mapping = {
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<CR>"] = cmp.mapping.confirm({
                        select = false,
                        behavior = cmp.ConfirmBehavior.Replace,
                    }),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    -- ["<Tab>"] = cmp.mapping(function(fallback)
                    --     -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
                    --     if cmp.visible() then
                    --         local entry = cmp.get_selected_entry()
                    --         if not entry then
                    --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    --         end
                    --         cmp.confirm()
                    --     elseif luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { "i", "s", "c", }),
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "path" },
                    { name = "cmdline" },
                },
            })

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            -- gray
            vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
            -- blue
            vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
            vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
            -- light blue
            vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
            vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
            vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
            -- pink
            vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
            vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
            -- front
            vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
            vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
            vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
            lspconfig.clangd.setup({
                -- root_dir = function(fname)
                --     return require("lspconfig.util").root_pattern(
                --         "Makefile",
                --         "configure.ac",
                --         "configure.in",
                --         "config.h.in",
                --         "meson.build",
                --         "meson_options.txt",
                --         "build.ninja"
                --     )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
                --         fname
                --     ) or require("lspconfig.util").find_git_ancestor(fname)
                -- end,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=chromium",
                },
                init_options = {
                    clangdFileStatus = true,
                    usePlaceholders = true,
                    completeUnimported = true,
                    -- fallbackFlags = { '--std=c++2b' },
                },
                capabilities = capabilities,
                flags = { allow_incremental_sync = false },
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.ruff.setup({
                capabilities = capabilities,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
            })
            -- lspconfig.verible.setup({
            --     capabilities = capabilities,
            -- })
            lspconfig.veridian.setup({
                cmd = { 'veridian' },
                root_dir = function(fname)
                    local lspconfutil = require 'lspconfig/util'
                    local root_pattern = lspconfutil.root_pattern("veridian.yml", ".git")
                    local filename = lspconfutil.path.is_absolute(fname) and fname
                        or lspconfutil.path.join(vim.loop.cwd(), fname)
                    return root_pattern(filename) or lspconfutil.path.dirname(filename)
                end,
                capabilities = capabilities,
            })
            lspconfig.texlab.setup({
                capabilities = capabilities,
                settings = {
                    texlab = {
                        build = {
                            args = {
                                "-pdf",
                                "-pdflatex",
                                "-shell-escape",
                                "-interaction=nonstopmode",
                                "-synctex=1",
                                "%f",
                            },
                            executable = "latexmk",
                            forwardSearchAfter = true,
                            onSave = true,
                        },
                        forwardSearch = {
                            executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
                            args = { "-g", "%l", "%p", "%f" },
                        },
                        chktex = {
                            onEdit = true,
                            onOpenAndSave = true,
                        },
                        latexindent = {
                            modifyLineBreaks = true,
                        },
                    },
                },
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
        end,
    },
    -- {
    --
    --     "williamboman/mason.nvim",
    --     config = function()
    --         require("mason").setup()
    --     end
    -- },
    -- {
    --     "williamboman/mason-lspconfig.nvim",
    --     dependencies = {
    --         "williamboman/mason.nvim",
    --     },
    --     config = function()
    --         require("mason-lspconfig").setup({
    --             -- ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "pyright" },
    --         })
    --     end
    -- },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async',
            "neovim/nvim-lspconfig",
        },
        config = function()
            require('ufo').setup()
        end
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        "hedyhli/outline.nvim",
        config = function()
            require("outline").setup({
                outline_window = {
                    position = 'right',
                    relative_width = true,
                },
                symbol_folding = {
                    autofold_depth = 2,
                    auto_unfold = {
                        hovered = true,
                    },
                },
                preview_window = {
                    auto_preview = false,
                },
            })
        end,
    },

    -- Debug
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup()
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dap_breakpoint = {
                error = {
                    -- text = "🧘🛑⊚⭕🟢🔵🚫👉⭐️⛔️🔴",
                    text = "🔴",
                    texthl = "LspDiagnosticsSignError",
                    linehl = "",
                    numhl = "",
                },
                rejected = {
                    text = "",
                    texthl = "LspDiagnosticsSignHint",
                    linehl = "",
                    numhl = "",
                },
                stopped = {
                    text = "👉",
                    texthl = "LspDiagnosticsSignInformation",
                    linehl = "DiagnosticUnderlineInfo",
                    numhl = "LspDiagnosticsSignInformation",
                },
            }

            vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
            vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
            vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

            dap.adapters.lldb = {
                type = "executable",
                command = "/opt/homebrew/opt/llvm/bin/lldb-dap", -- adjust as needed, must be absolute path
                name = "lldb",
            }

            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,

                    args = function()
                        local input = vim.fn.input("Input args: ")
                        return vim.fn.split(input, '\\s\\+', true)
                    end,

                    runInTerminal = true,
                },

            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },

    -- File Manager
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                filters = { custom = { "^.git$" }, },
            })
        end,
    },

    -- Note Taking
    -- {
    --     "epwalsh/obsidian.nvim",
    --     version = "*", -- recommended, use latest release instead of latest commit
    --     lazy = true,
    --     ft = "markdown",
    --     -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    --     -- event = {
    --     --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --     --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --     --   "BufReadPre path/to/my-vault/**.md",
    --     --   "BufNewFile path/to/my-vault/**.md",
    --     -- },
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    --     opts = {
    --         workspaces = {
    --             {
    --                 name = "personal",
    --                 path = "~/Documents/personal",
    --             },
    --             {
    --                 name = "work",
    --                 path = "~/Documents/work",
    --             },
    --         },
    --     },
    -- },

    -- Other Functions
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs      = {
                    add          = { text = 'A┃' },
                    change       = { text = 'C┃' },
                    delete       = { text = 'D_' },
                    topdelete    = { text = 'D‾' },
                    changedelete = { text = 'D~' },
                    untracked    = { text = 'U┆' },
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = true,  -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`

                on_attach  = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end)

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end)

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk)
                    map('n', '<leader>hr', gitsigns.reset_hunk)
                    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('n', '<leader>hS', gitsigns.stage_buffer)
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
                    map('n', '<leader>hR', gitsigns.reset_buffer)
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                    map('n', '<leader>hd', gitsigns.diffthis)
                    map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
                    map('n', '<leader>td', gitsigns.toggle_deleted)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end,
            })
        end,
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            local toggleterm = require('toggleterm')
            toggleterm.setup({
                winbar = {
                    enabled = false,
                    name_formatter = function(term) --  term: Terminal
                        return term.name
                    end
                },
                open_mapping = '<C-\\>',
                direction = 'horizontal',
                shade_terminals = true,
                close_on_exit = true,    -- close the terminal window when the process exits
                start_in_insert = true,
                insert_mappings = false, -- whether or not the open mapping applies in insert mode
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                mappings = {
                    i = {
                        ["<C-n>"] = "move_selection_next",
                        ["<C-p>"] = "move_selection_previous",
                        ["<Down>"] = "cycle_history_next",
                        ["<Up>"] = "cycle_history_prev",
                        ["<C-u>"] = "preview_scrolling_up",
                        ["<C-d>"] = "preview_scrolling_down",
                    },
                },
            })
            telescope.load_extension("projects")
            telescope.load_extension("undo")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn", -- set to `false` to disable one of the mappings
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
            })
        end,
    },
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup()
        end,
    },
    {
        "CRAG666/code_runner.nvim",
        dependencies = {
            'akinsho/toggleterm.nvim',
        },
        config = function()
            require("code_runner").setup({
                mode = "toggleterm",
                filetype = {
                    javascript = "node",
                    java = "cd $dir && javac $fileName && time java $fileNameWithoutExt",
                    c =
                    -- "cd $dir && clang -g -Wl,-stack_size -Wl,0x10000000 -Wextra -fsanitize=address -Wall -Wsign-compare -Wwrite-strings -Wtype-limits $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
                    "cd $dir && clang $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
                    cpp =
                    "cd $dir && clang++ --std=gnu++26 $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
                    python = "time python3 -u",
                    typescript = "time deno run",
                    sh = "zsh",
                    -- rust = "cd $dir && rustc $fileName && time $dir/$fileNameWithoutExt",
                    rust = "cd $dir && cargo build && time cargo run",
                    markdown =
                    "pandoc -f markdown --pdf-engine=xelatex --listings --template eisvogel $fileName -o $fileNameWithoutExt.pdf",
                },
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "rmagatti/auto-session",
        lazy = false,
        dependencies = {
            'nvim-telescope/telescope.nvim', -- Only needed if you want to use session lens
        },
        config = function()
            require("auto-session").setup({
                auto_session_enabled = true,
                auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
                auto_save_enabled = true,
                auto_restore_enabled = false,
                pre_save_cmds = { "NvimTreeClose", "OutlineClose", },
                bypass_session_save_file_types = { 'alpha', 'dashboard' },
                session_lens = {
                    load_on_setup = true,
                    theme_conf = { border = true },
                    previewer = false,
                },
            })
        end,
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require('neoscroll').setup({
                mappings = { -- Keys to be mapped to their corresponding default scrolling animation
                    '<C-u>', '<C-d>',
                    -- '<C-b>', '<C-f>',
                    '<C-y>', '<C-e>',
                    -- 'zt', 'zz', 'zb',
                },
                hide_cursor = false,         -- Hide cursor while scrolling
                stop_eof = true,             -- Stop at <EOF> when scrolling downwards
                respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing = 'sine',             -- Default easing function
                pre_hook = nil,              -- Function to run before the scrolling animation starts
                post_hook = nil,             -- Function to run after the scrolling animation ends
                performance_mode = false,    -- Disable "Performance Mode" on all buffers.
            })
        end
    },
    -- {
    --     'ojroques/nvim-osc52',
    --     config = function()
    --         require('osc52').setup {
    --             max_length = 0, -- Maximum length of selection (0 for no limit)
    --             silent = false, -- Disable message on successful copy
    --             trim = false, -- Trim surrounding whitespaces before copy
    --             tmux_passthrough = false, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
    --         }
    --
    --         local function copy(lines, _)
    --             require('osc52').copy(table.concat(lines, '\n'))
    --         end
    --
    --         local function paste()
    --             return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
    --         end
    --
    --         vim.g.clipboard = {
    --             name = 'osc52',
    --             copy = { ['+'] = copy, ['*'] = copy },
    --             paste = { ['+'] = paste, ['*'] = paste },
    --         }
    --     end,
    -- },
})
