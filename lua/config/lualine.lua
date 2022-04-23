-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    theme = "tokoynight",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    icons_enabled = true,
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {
      {'mode'},
      --{ "filename", path = 1, symbols = { modified = "  ", readonly = "" } },
      {'buffers',
        mode = 2,
        max_length = vim.o.columns * 2 / 3,

    },
    },
    lualine_b = {
      { "filesize", cond = conditions.buffer_not_empty},
      { "branch", icon = '',},
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
      }
    },
    lualine_c = {
    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
        { '%='},
        {
            function ()
               local msg = 'No Active LSP'
               local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
               local clients = vim.lsp.get_active_clients()
               if next(clients) == nil then
                   return msg
               end
               for _, client in ipairs(clients) do
                   local filetypes = client.config.filetypes
                   if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                       return client.name
                   end
               end
               return msg
            end,
            icon = ' LSP:',
            color = { fg = '#ffffff', gui = 'bold' },
        },
    },
    lualine_x = {
        {
            'diff',
            colored = true,
            symbols = { added = ' ', modified = '柳 ', removed = ' ' },
            cond = conditions.hide_in_width,
        },
    },
    lualine_y = {
        {'location'},
        {'progress'},
    },
    lualine_z = { 
        {'diff'}, {'encoding'}, {'fileformat'} 
    },
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {'filename'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {'nvim-tree'},
}

local M = {}

function M.load()
  local name = vim.g.colors_name or ""
  local ok, _ = pcall(require, "lualine.themes." .. name)
  if ok then
    config.options.theme = name
  end
  require("lualine").setup(config)
end

M.load()

-- vim.api.nvim_exec([[
--   autocmd ColorScheme * lua require("config.lualine").load();
-- ]], false)

return M


-- Now don't forget to initialize lualine
--lualine.setup(config)
