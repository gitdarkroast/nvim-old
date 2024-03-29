local wk = require("which-key")
local util = require("util")

vim.o.timeoutlen = 300

local presets = require("which-key.plugins.presets")
presets.objects["a("] = nil
wk.setup({
	show_help = true, -- show help message on the command
	triggers = "auto",
	plugins = {
		marks = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
	},
	presets = {
		operators = true,
		motions = true,
		text_objects = true,
		windows = true,
		nav = true,
		z = true,
		g = true,
	},
	key_labels = {
		["<leader>"] = "SPC",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
})

-- Move to window using the <ctrl> movement keys
util.nmap("<C-h>", "<C-w>h")
util.nmap("<C-j>", "<C-w>j")
util.nmap("<C-k>", "<C-w>k")
util.nmap("<C-l>", "<C-w>l")

-- Resize window using <ctrl> arrow keys
util.nnoremap("<S-Up>", ":resize +2<CR>")
util.nnoremap("<S-Down>", ":resize -2<CR>")
util.nnoremap("<S-Left>", ":vertical resize -2<CR>")
util.nnoremap("<S-Right>", ":vertical resize +2<CR>")

-- Disable Arrow keys
util.nnoremap("<Up>", "<Nop>")
util.nnoremap("<Down>", "<Nop>")
util.nnoremap("<Left>", "<Nop>")
util.nnoremap("<Right>", "<Nop>")

-- Move Lines
util.nnoremap("<A-j>", ":m .+1<CR>==")
util.vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
util.inoremap("<A-j>", "<Esc>:m .+1<CR>==gi")
util.nnoremap("<A-k>", ":m .-2<CR>==")
util.vnoremap("<A-k>", ":m '<-2<CR>gv=gv")
util.inoremap("<A-k>", "<Esc>:m .-2<CR>==gi")

-- the following buffer moves require cokeline plugin
util.nnoremap("<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
util.nnoremap("<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
util.nnoremap("<Leader>p", "<Plug>(cokeline-switch-prev)", { silent = true })
util.nnoremap("<Leader>n", "<Plug>(cokeline-switch-next)", { silent = true })

for i = 1, 9 do
	util.nnoremap(("<Leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), { silent = true })
end

-- Easier pasting
util.nnoremap("[p", ":pu!<cr>")
util.nnoremap("]p", ":pu<cr>")

-- Clear search with <esc>
util.map("", "<esc>", ":noh<cr>")
util.nnoremap("gw", "*N")
util.xnoremap("gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
util.nnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.xnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.onoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.nnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.xnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.onoremap("N", "'nN'[v:searchforward]", { expr = true })

-- Add undo break-points
util.inoremap(",", ",<c-g>u")
util.inoremap(".", ".<c-g>u")
util.inoremap(";", ";<c-g>u")

-- save in insert mode
util.inoremap("<C-s>", "<esc>:w<cr>")
util.nnoremap("<C-s>", "<esc>:w<cr>")
util.nnoremap("<C-c>", "<esc>ciw")

-- better indenting
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")

-- Toggle Neotree
util.nnoremap("<leader>e", ":Neotree reveal left<CR>")

wk.register({
	["]"] = {
		name = "next",
		r = { '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', "Next Reference" },
	},
	["["] = {
		name = "previous",
		r = { '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', "Next Reference" },
	},
})

-- makes * and # work on visual mode too.
vim.api.nvim_exec(
	[[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
	false
)

local leader = {
	["w"] = {
		name = "+windows",
		["w"] = { "<C-W>p", "other-window" },
		["d"] = { "<C-W>c", "delete-window" },
		["-"] = { "<C-W>s", "split-window-below" },
		["|"] = { "<C-W>v", "split-window-right" },
		["2"] = { "<C-W>v", "layout-double-columns" },
		["h"] = { "<k-W>h", "window-left" },
		["j"] = { "<C-W>j", "window-below" },
		["l"] = { "<C-W>l", "window-right" },
		["k"] = { "<C-W>k", "window-up" },
		["H"] = { "<C-W>5<", "expand-window-left" },
		["J"] = { ":resize +5", "expand-window-below" },
		["L"] = { "<C-W>5>", "expand-window-right" },
		["K"] = { ":resize -5", "expand-window-up" },
		["="] = { "<C-W>=", "balance-window" },
		["r"] = { ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR>:redraw!<CR>", "redraw the screen" },
		["s"] = { "<C-W>s", "split-window-below" },
		["v"] = { "<C-W>v", "split-window-right" },
	},
	c = { v = { "<cmd>Vista!!<CR>", "Vista" }, o = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" } },
	b = {
		name = "+buffer",
		["b"] = { "<Plug>(cokeline-switch-next)", "Switch to Other Buffer" },
		["p"] = { "<Plug>(cokeline-focus-prev)", "Previous Buffer" },
		["["] = { "<Plug>(cokeline-focus-prev)", "Previous Buffer" },
		["n"] = { "<Plug>(cokeline-focus-next)", "Next Buffer" },
		["]"] = { "<Plug>(cokeline-focus-next)", "Next Buffer" },
		["d"] = { "<Plug>(cokeline-pick-close)", "Delete Buffer" },
		["g"] = { "<Plug>(cokeline-pick-focus)", "Goto Buffer" },
	},
	g = {
		name = "+git",
        b = { "<Cmd>Telescope git_branches<CR>", "branches" },
		c = { "<Cmd>Telescope git_commits<CR>", "commits" },
        d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
        h = { name = "+hunk" },
        n = { ":Neogit<CR>", "Neogit"},
		s = { "<Cmd>Telescope git_status<CR>", "status" },
	},
	["h"] = {
		name = "+help",
		t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
		c = { "<cmd>:Telescope commands<cr>", "Commands" },
		h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
		m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
		k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
		s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
		l = { [[<cmd>TSHighlightCapturesUnderCursor<cr>]], "Highlight Groups at cursor" },
		f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
		o = { "<cmd>:Telescope vim_options<cr>", "Options" },
		a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
		p = {
			name = "+packer",
			p = { "<cmd>PackerSync<cr>", "Sync" },
			s = { "<cmd>PackerStatus<cr>", "Status" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			c = { "<cmd>PackerCompile<cr>", "Compile" },
		},
	},
	u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
	s = {
		name = "+search",
		g = { "<cmd>Telescope live_grep<cr>", "Grep" },
		b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
		s = {
			function()
				require("telescope.builtin").lsp_document_symbols({
					symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module" },
				})
			end,
			"Goto Symbol",
		},
		h = { "<cmd>Telescope command_history<cr>", "Command History" },
		m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
		r = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" },
		w = { "<cmd>lua require('spectre').open()<CR>", "Search current word (Spectre)" },
	},
	f = {
		name = "+file",
		t = { "<cmd>Neotree<cr>", "Neotree" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		n = { "<cmd>enew<cr>", "New File" },
		z = "Zoxide",
		d = "Dot Files",
	},
	o = {
		name = "+open",
		p = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
		g = { "<cmd>Glow<cr>", "Markdown Glow" },
		n = { "<cmd>lua require('github-notifications.menu').notifications()<cr>", "GitHub Notifications" },
	},
	p = {
		name = "+workspace",
		p = "Open workspace",
		b = { ":Telescope find_files cwd=~/workspace<CR>", "Browse ~/workspace" },
	},
	t = {
		name = "toggle",
		f = {
			require("config.lsp.formatting").toggle,
			"Format on Save",
		},
		s = {
			function()
				util.toggle("spell")
			end,
			"Spelling",
		},
		w = {
			function()
				util.toggle("wrap")
			end,
			"Word Wrap",
		},
		n = {
			function()
				util.toggle("relativenumber", true)
				util.toggle("number")
			end,
			"Line Numbers",
		},
	},
	["<tab>"] = {
		name = "workspace",
		["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },

		n = { "<cmd>tabnext<CR>", "Next" },
		d = { "<cmd>tabclose<CR>", "Close" },
		p = { "<cmd>tabprevious<CR>", "Previous" },
		["]"] = { "<cmd>tabnext<CR>", "Next" },
		["["] = { "<cmd>tabprevious<CR>", "Previous" },
		f = { "<cmd>tabfirst<CR>", "First" },
		l = { "<cmd>tablast<CR>", "Last" },
	},
	["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
	[" "] = "Find File",
	["."] = { ":Telescope find_files<CR>", "Find Files" },
	["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
	[","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
	[":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
	q = {
		name = "+quit/session",
		q = { "<cmd>:qa<cr>", "Quit" },
		["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
		s = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session" },
		l = { [[<cmd>lua require("persistence").load({last=true})<cr>]], "Restore Last Session" },
		d = { [[<cmd>lua require("persistence").stop()<cr>]], "Stop Current Session" },
	},
	x = {
		name = "+errors",
		x = { "<cmd>Neotree diagnostics reveal bottom<cr>", "Document Diagnostics" },
	},
	Z = { [[<cmd>lua require("zen-mode").reset()<cr>]], "Zen Mode" },
	z = { [[<cmd>ZenMode<cr>]], "Zen Mode" },
	T = { [[<Plug>PlenaryTestFile]], "Plenary Test" },
	D = {
		function()
			util.docs()
		end,
		"Create Docs from README.md",
	},
}

for i = 0, 10 do
	leader[tostring(i)] = "which_key_ignore"
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

wk.register(leader, opts)

-- wk.register({ g = { name = "+goto", h = "Hop Word" }, s = "Hop Word1" })
