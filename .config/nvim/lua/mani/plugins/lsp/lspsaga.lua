-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end

saga.setup({
  -- keybinds for navigation in lspsaga window
  symbol_in_winbar = {
    enable = false,
  },
  scoll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
  -- use enter to open file with definition preview
  definition = {
    keys = "<CR>",
  },
  ui = {
    colors = {
      normal_bg = "#022746",
    },
  },
})
