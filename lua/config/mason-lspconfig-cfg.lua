local status_ok, mlsp = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

mlsp.setup({
    ensure_installed = { 
        "sumneko_lua", 
        "rust_analyzer",
        "clangd",
        "pyright",
        "gopls",
    }
})
