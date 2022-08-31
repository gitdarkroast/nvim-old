-- set the color scheme you want to use
local colorscheme = "gruvbox"
local status_ok, cs = pcall(require, colorscheme)
if not status_ok then
    return
end

-- gruvbox
cs.setup({
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

