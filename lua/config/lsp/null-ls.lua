local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
--local code_action = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
        -- formatting
		--formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
        formatting.clang_format,
        formatting.gofmt,

        -- diagnostics
		diagnostics.flake8,
        diagnostics.cppcheck.with({
            extra_args = { "--enable=warning,style,performance,portability", "--template=gcc", "$FILENAME" }
        }),

        -- code_actions
        --code_action.gitsigns,
	},
    diagnostics_format = "[#{c}] #{m} (#{s})",
})
