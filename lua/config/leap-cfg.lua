local status_ok, leap = pcall(require, "leap")
if not status_ok then
    return
end

leap.setup {
  highlight_ahead_of_time = true,
  highlight_unlabeled = false,
  case_sensitive = false,
  -- Groups of characters that should match each other.
  -- E.g.: { "([{<", ")]}>", "'\"`", }
    character_classes = {},
  -- Leaving the appropriate list empty effectively disables "smart" mode,
  -- and forces auto-jump to be on or off.
  -- safe_labels = { . . . },
  -- labels = { . . . },
  -- These keys are captured directly by the plugin at runtime.
  special_keys = {
    repeat_search = '<enter>',
    next_match    = '<enter>',
    prev_match    = '<tab>',
    next_group    = '<space>',
    prev_group    = '<tab>',
    eol           = '<space>',
  },
}

leap.set_default_keymaps()
