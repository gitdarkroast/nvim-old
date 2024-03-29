local wk = require("which-key")
local util = require("util")

local M = {}

function M.setup(client, bufnr)
    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = bufnr }

    local keymap = {
        c = {
            name = "+code",
            a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
            c = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename (Change)" },
            d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
            r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
            l = {
                name = "+lsp",
                i = { "<cmd>LspInfo<cr>", "Lsp Info" },
                a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Folder" },
                r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Folder" },
                l = {
                    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                    "List Folders",
                },
            },
        },
        x = {
            s = { "<cmd>Telescope document_diagnostics<cr>", "Search Document Diagnostics" },
            w = { "<cmd>Telescope workspace_diagnostics<cr>", "Workspace Diagnostics" },
        },
    }

    if client.name == "typescript" then
        keymap.c.o = { "<cmd>:TSLspOrganize<CR>", "Organize Imports" }
        keymap.c.R = { "<cmd>:TSLspRenameFile<CR>", "Rename File" }
    end

    local keymap_visual = {
        c = {
            name = "+code",
            a = { ":<C-U>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
        },
    }

    local keymap_goto = {
            name = "+goto",
            r = { "<cmd>Telescope lsp_references<cr>", "References" },
            R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
            d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
            dv = { "<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>", "Goto Definition (VSplit)" },
            ds = { "<Cmd>split | lua vim.lsp.buf.definition()<CR>", "Goto Definition (HSplit)" },
            s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
            I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
            -- I = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
            t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
        }

    util.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    util.nnoremap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    util.nnoremap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    util.nnoremap("[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
    util.nnoremap("]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)

    local trigger_chars = client.resolved_capabilities.signature_help_trigger_characters
    trigger_chars = { "," }
    for _, c in ipairs(trigger_chars) do
        util.inoremap(c, function()
            vim.defer_fn(function()
                pcall(vim.lsp.buf.signature_help)
            end, 0)
            return c
        end, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            expr = true,
        })
    end

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        keymap.c.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
    elseif client.resolved_capabilities.document_range_formatting then
        keymap_visual.c.f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format Range" }
    end

    wk.register(keymap, { buffer = bufnr, prefix = "<leader>" })
    wk.register(keymap_visual, { buffer = bufnr, prefix = "<leader>", mode = "v" })
    wk.register(keymap_goto, { buffer = bufnr, prefix = "g" })
end

return M
