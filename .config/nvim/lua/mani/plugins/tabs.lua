-- import barbar tabs safely
local tabs_setup, tabs = pcall(require, "barbar")
if not tabs_setup then
  return
end

-- configure barbar tabs
tabs.setup({
  animation = true,

  auto_hide = true,

  clickable = true,

  highlight_inactive_file_icons = false,

  icons = {
    buffer_index = false,

    buffer_number = false,

     diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },

    gitsigns = {
      added = { enabled = true, icon = "+" },
      changed = { enabled = true, icon = "~" },
      deleted = { enabled = true, icon = "-" },
    }
  },

  maximum_length = 1,


})
