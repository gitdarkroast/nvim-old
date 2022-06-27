require("config.lsp.diagnostics").setup()
require("config.lsp.kind").setup()
--local diagnostics = require("diagnostics")

local function on_attach(client, bufnr)
	require("config.lsp.formatting").setup(client, bufnr)
	require("config.lsp.keys").setup(client, bufnr)
	require("config.lsp.completion").setup(client, bufnr)
	require("config.lsp.highlighting").setup(client)

	-- TypeScript specific stuff
	if client.name == "typescript" or client.name == "tsserver" then
		require("config.lsp.ts-utils").setup(client)
	end
end

local servers = {
	-- clangd = {},
	-- dockerls = {},
	-- jsonls = {},
	-- pyright = {},
	-- rust_analyzer = {
	-- 	settings = {
	-- 		["rust-analyzer"] = {
	-- 			cargo = { allFeatures = true },
	-- 			-- enable clippy on save
	-- 			checkOnSave = {
	-- 				command = "clippy",
	-- 				extraArgs = { "--no-deps" },
	-- 			},
	-- 		},
	-- 	},
	-- },
	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},
	-- vimls = {},
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lua-dev").setup()

local options = {
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}
require("config.lsp.null-ls").setup(options)
require("config.lsp.install").setup(servers, options)
