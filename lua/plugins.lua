local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    execute("packadd packer.nvim")
end

-- autocompile
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-- The list of plugins
return require("packer").startup(function(use)
    use({ "wbthomason/packer.nvim" })
    use({ "lewis6991/impatient.nvim" })
    use({
        "rcarriga/nvim-notify",
        event = "VimEnter",
        config = function()
            vim.notify = require("notify")
        end,
    })
    -- LSP
    use({
        "neovim/nvim-lspconfig",
        opt = true,
        event = "BufReadPre",
        wants = {
            "nvim-lsp-ts-utils",
            "null-ls.nvim",
            "lua-dev.nvim",
            "cmp-nvim-lsp",
            "nvim-lsp-installer",
        },
        config = function()
            require("config.lsp")
        end,
        requires = {
            "jose-elias-alvarez/nvim-lsp-ts-utils",
            "jose-elias-alvarez/null-ls.nvim",
            "folke/lua-dev.nvim",
            "williamboman/nvim-lsp-installer",
        },
    })
    -- Visual representation of undo
    use({ "mbbill/undotree", cmd = "UndotreeToggle" })
    -- Additional Language tools
    -- Rust
    use({
        "simrat39/rust-tools.nvim",
        module = "rust-tools",
    })
    use({ "kazhala/close-buffers.nvim", cmd = "BDelete" })
    -- Code completion
    use({
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        opt = true,
        config = function()
            require("config.compe")
        end,
        wants = { "LuaSnip" },
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer", -- buffer completion
            "hrsh7th/cmp-path", -- path completion
            "hrsh7th/cmp-cmdline", -- cmdline completion
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                wants = "friendly-snippets",
                config = function()
                    require("config.snippets")
                end,
            },
            "rafamadriz/friendly-snippets",
            {
                module = "nvim-autopairs",
                "windwp/nvim-autopairs",
                config = function()
                    require("config.autopairs")
                end,
            },
        },
    })
    -- Automatic insertion and deletion of a pair of characters
    use({ "Raimondi/delimitMate", event = "InsertEnter" })
    -- Theme: color schemes
    use({
        --        "folke/tokyonight.nvim",
        "EdenEast/nightfox.nvim",
        --       "LunarVim/onedarker.nvim",
        --          "LunarVim/darkplus.nvim",
        config = function()
            require("config.theme")
        end,
    })
    -- Theme: icons
    use({
        "kyazdani42/nvim-web-devicons",
        module = "nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end,
    })
    -- Dashboard
    use({ "glepnir/dashboard-nvim", config = [[require('config.dashboard')]] })
    use({
        "norcalli/nvim-terminal.lua",
        ft = "terminal",
        config = function()
            require("terminal").setup()
        end,
    })
    use({ "nvim-lua/plenary.nvim", module = "plenary" })
    use({ "nvim-lua/popup.nvim", module = "popup" })

    use({
        "windwp/nvim-spectre",
        opt = true,
        module = "spectre",
        wants = { "plenary.nvim", "popup.nvim" },
        requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    })
    -- Fast file tree
    use({
        "kyazdani42/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeClose" },
        config = function()
            require("config.tree")
        end,
    })
    -- Fuzzy finder
    use({
        "nvim-telescope/telescope.nvim",
        opt = true,
        config = function()
            require("config.telescope")
        end,
        cmd = { "Telescope" },
        module = "telescope",
        keys = { "<leader><space>", "<leader>fz", "<leader>pp" },
        wants = {
            "plenary.nvim",
            "popup.nvim",
            "telescope-z.nvim",
            "telescope-fzy-native.nvim",
            "telescope-project.nvim",
            "trouble.nvim",
            "telescope-symbols.nvim",
        },
        requires = {
            "nvim-telescope/telescope-z.nvim",
            "nvim-telescope/telescope-project.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
        },
    })
    -- Indent Guides and rainbow brackets
    use({
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            require("config.blankline")
        end,
    })

    -- Tabs
    use({
        "akinsho/bufferline.nvim",
        event = "BufReadPre",
        wants = "nvim-web-devicons",
        config = function()
            require("config.bufferline")
        end,
    })

    -- Terminal
    use({
        "akinsho/nvim-toggleterm.lua",
        keys = "<M-`>",
        config = function()
            require("config.terminal")
        end,
    })

    use({
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        module = "diffview",
        config = function()
            require("config.diffview")
        end,
    })

    use({
        "folke/which-key.nvim",
        event = "VimEnter",
        config = function()
            require("config.keys")
        end,
    })

    use({
        "folke/trouble.nvim",
        event = "BufReadPre",
        wants = "nvim-web-devicons",
        cmd = { "TroubleToggle", "Trouble" },
        config = function()
            require("trouble").setup({
                auto_open = false,
                use_diagnostic_signs = true, -- en
            })
        end,
    })

    use({
        "RRethy/vim-illuminate",
        event = "CursorHold",
        module = "illuminate",
        config = function()
            vim.g.Illuminate_delay = 1000
        end,
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        opt = true,
        event = "BufRead",
        requires = {
        { "nvim-treesitter/playground", opt = true, cmd = "TSHighlightCapturesUnderCursor" },
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-textsubjects",
        },
        config = [[require('config.treesitter')]],
    })
    -- Search and command suggestions
    use({
        'gelguy/wilder.nvim',
        event = "VimEnter",
        config = function()
            require("config.wilder")
        end,
    })

    use { 'kevinhwang91/nvim-hlslens' }

    -- Statusline
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "rlch/github-notifications.nvim" },
        event = "VimEnter",
        config = [[require('config.lualine')]],
        wants = "nvim-web-devicons",
    })
    use({
        "norcalli/nvim-colorizer.lua",
        event = "BufReadPre",
        config = function()
            require("config.colorizer")
        end,
    })

    use({
        "ggandor/lightspeed.nvim",
        keys = { "s", "S", "f", "F", "t", "T" },
        config = function()
            require("config.lightspeed")
        end,
    })

    -- Git
    use({
        "TimUntersberger/neogit",
        cmd = "Neogit",
        config = function()
            require("config.neogit")
        end,
    })

    -- Git Gutter
    use({
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        wants = "plenary.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.gitsigns")
        end,
    })

end) -- startup
