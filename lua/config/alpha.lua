local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	"                         ,-.        _.---._ ",
	"                        |  `.__.-''       `. ",
	"                          _        _  ,.    ",
	"  ,+++=._________________)_||______|_|_||    | ",
	" (_.ooo.===================||======|=|=||    | ",
	"    ~~'                 |  ~'      `~' o o  / ",
	"                            /~`     o o  / ",
	"                          `~'    `-.____.-' ",
}
-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("Leader f f", "  > Find file", "<cmd>Telescope find_files<CR>"),
	dashboard.button("Leader f r", "  > Recent files", "<cmd>Telescope oldfiles<CR>"),
	dashboard.button("Leader s g", "  > Project grep", "<cmd>Telescope live_grep<CR>"),
	dashboard.button("Leader h p s", "  > Update plugins", ":PackerSync<CR>"),
	dashboard.button("Leader f n", "  > New file", ":enew <CR>"),
	dashboard.button("Leader q q", "  > Quit NVIM", ":qa<CR>"),
}

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)

-- Send config to alpha
alpha.setup(dashboard.opts)
