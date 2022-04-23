local signs = require("config.lsp.diagnostics").signs

signs = {
  error = signs.Error,
  warning = signs.Warn,
  info = signs.Info,
  hint = signs.Hint,
}

local severities = {
  "error",
  "warning",
  -- "info",
  -- "hint",
}

require("bufferline").setup({
  options = {
    numbers = function(opts)
        return string.format('[%s]',  opts.id)
    end,
    show_close_icon = true,
    indicator_icon = "▎",
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    separator_style = "thick",
    diagnostics_indicator = function(_, _, diag)
      local s = {}
      for _, severity in ipairs(severities) do
        if diag[severity] then
          table.insert(s, signs[severity] .. diag[severity])
        end
      end
      return table.concat(s, " ")
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "NvimTree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})

