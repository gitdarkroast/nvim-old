-- set the color scheme you want to use
local colorscheme = "nightfox"
local status_ok, cs = pcall(require, colorscheme)
if not status_ok then
    return
end

-- nightfox
cs.setup({
    options = {
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled",
        transparent = false,
        terminal_colors = true,
        dim_inactive = true,
        styles = {
                comments = "italic",
                keywords = "bold",
                types = "italic,bold",
        },
        inverse = {
                match_paren = true,
                visual = true,
                search = true,
        },
        moduldes = {
                "gitsigns",
                "illuminate",
                "lightspeed",
                "lsp_trouble",
                "nvimtree",
                "telescope",
                "treesitter",
                "whichkey",
            },
    },
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. "not found!")
	return
end

-- Update the Lualine status line
require("lualine").setup({
	options = {
		theme = colorscheme
	}
})
