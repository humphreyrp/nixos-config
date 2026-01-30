vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.ignorecase = true;
vim.opt.smartcase = true;
vim.opt.showtabline = 0

vim.opt.colorcolumn = "100"

-- Don't wrap, because it starts to look weird when you have files side by side
vim.opt.wrap = false

-- Remap jump keys, to deconflict with zellij
vim.keymap.set('n', '<C-j>', '<C-o>', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-i>', { noremap = true })

-- Move cursor multiple lins
vim.keymap.set({"n", "v"}, 'J', '10j', { noremap = true })
vim.keymap.set({"n", "v"}, 'K', '10k', { noremap = true })

-- Disable the mouse so we can just use the sytem click handling (copy/paste)
vim.opt.mouse = ""

-- Reduce updatetime so plugins can update more quickly
vim.opt.updatetime = 500

-- Whitespace stripping
vim.keymap.set('n', 'fw', ':StripWhitespace<CR>', { noremap = true, silent = true })

-- LSP Config
vim.diagnostic.config({
    underline = true,
    virtual_text = true,     -- This shows inline error text. Set to false if you don't want it.
    signs = true,
    update_in_insert = true, -- Set to true if you want updates during insert mode.
})

vim.opt.signcolumn = 'yes'

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { silent = true })
vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, { silent = true })
vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', 'gk', '<cmd>lua vim.diagnostic.open_float(nil, {focus=false, scope="line"})<CR>', { silent = true })
vim.keymap.set('n', 'gv', '<cmd>lua vim.diagnostic.setloclist()<CR>', { silent = true })
vim.keymap.set('n', 'gj', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.format({ async = false })<CR>', { silent = false })
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { silent = true })
vim.keymap.set('n', 'gm', '<cmd>ClangdSwitchSourceHeader<CR>', { silent = true })

vim.lsp.config['hls'] = {
    cmd = { "haskell-language-server", "--lsp" },
    settings = {
        haskell = {
            formattingProvider = 'fourmolu',
            cabalFormattingProvider = 'cabalfmt',
        },
    },
    on_attach = function(client, bufnr)
    end,
}
vim.lsp.config['pylsp'] = {
    settings = {
        pylsp = {
            plugins = {
                yapf = {
                    enabled = true
                }
            }
        }
    }
}
-- This was all taken from comments in the lspconfig git repository
vim.lsp.config['lua_ls'] = {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
}
vim.lsp.enable({'hls', 'clangd', 'cmake', 'dhall_lsp_server', 'pylsp', 'nixd', 'rust_analyzer', 'lua_ls'})

-- Tries to speed up the LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

-- Telescope Config
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'To',
    function() builtin.find_files({ find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' } }) end, {})
vim.keymap.set('n', 'Tf', function () builtin.live_grep({ additional_args = { '--hidden', '--glob', '!**/.git/*' } }) end, {})
vim.keymap.set('n', 'Tb', function() builtin.buffers({ sort_mru = true }) end, {})
vim.keymap.set('n', 'Th', builtin.help_tags, {})
vim.keymap.set('n', 'Tr', builtin.lsp_references, {})
vim.keymap.set('n', 'Td', builtin.lsp_definitions, {})

local telescope = require('telescope')
telescope.setup {
    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.5
            },
        },
    },
}

telescope.load_extension "file_browser"
-- Open the file browser in the root directory
vim.keymap.set("n", "<space>r", ":Telescope file_browser<CR>")
-- Open the file browser in the current directory
vim.keymap.set("n", "<space>o", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

-- Auto-session Config
require("auto-session").setup {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
}

-- Auto-complete config
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' }, -- For ultisnips users.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Comments, use ctrl + / to comment visual blocks
require('Comment').setup {
    opleader = {
        line = '<C-_>'
    },
}

-- Setup the color scheme
local colors = require('vscode').setup({
    color_overrides = {
        vscPopupBack = '#363636',
    },
})
vim.cmd.colorscheme "vscode"

-- Enable and configure git blame. This needs to be after the color scheme is setup otherwise
-- it will be overwritten
vim.cmd([[highlight Blamer guifg=#4e4e4e]])
vim.g.blamer_enabled = true

require("scrollbar").setup({
    handle = {
        color = colors.bg_highlight,
    },
})
