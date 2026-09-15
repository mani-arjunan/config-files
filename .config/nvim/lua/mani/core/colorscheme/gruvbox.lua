local status, gruvbox = pcall(require, "gruvbox")
if not status then
  return
end

gruvbox.setup({
  contrast = "soft",              -- bg #32302f instead of #1d2021
  transparent_mode = true,
  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = false,
  },
  palette_overrides = {
    bright_red    = "#c1584f",
    bright_green  = "#a3a44e",
    bright_yellow = "#cfa54e",
    bright_blue   = "#7e9a9b",
    bright_purple = "#b58a91",
    bright_aqua   = "#89a07b",
    bright_orange = "#c07a44",
    light1        = "#d5c4a1",   -- default fg, down from #ebdbb2
  },
  overrides = {
    CursorLine = { bg = "#3c3836" },
    Visual     = { bg = "#504945" },
    StatusLine = { fg = "#d8a657", bg = "#32302f" },
    PmenuSel   = { fg = "#1d2021", bg = "#a9702f" },
    NvimTreeNormal   = { bg = "NONE" },
    NvimTreeNormalNC = { bg = "NONE" },
    NvimTreeSpecialFile = { fg = "NONE", underline = false },
  },
})

vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")
