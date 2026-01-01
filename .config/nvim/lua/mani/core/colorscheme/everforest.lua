-- import everforest safely
local autopairs_setup, everforest = pcall(require, "everforest")
if not autopairs_setup then
  return
end

everforest.setup({
  background = "hard",
  transparent_background_level = 10,
  italics = false,
  disable_italic_comments = true,
  sign_column_background = "none",
  ui_contrast = "high",
  dim_inactive_windows = true,
  diagnostic_text_highlight = true,
  diagnostic_virtual_text = "coloured",
  diagnostic_line_highlight = true,
  spell_foreground = false,
  show_eob = true,
  float_style = "bright",
  inlay_hints_background = "none",
})

vim.cmd.colorscheme("everforest")

-- for transparency
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight MsgArea guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
]])

-- to set transparency in nvim-tree
vim.cmd([[
  highlight NvimTreeNormal guibg=NONE ctermbg=NONE
  highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
  highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
  highlight NvimTreeEndOfBuffer guifg=#1d2021
]])

vim.api.nvim_set_hl(0, "Visual", {
  bg = "#3a3f3a",
})

vim.api.nvim_set_hl(0, "CursorLine", {
  bg = "#3a3f3a",
})

vim.api.nvim_set_hl(0, "NvimTreeCursorLine", {
  bg = "#2c304a",
})

vim.api.nvim_set_hl(0, "Search", {
  bg = "#3b3f33",
  fg = "NONE",
})

vim.api.nvim_set_hl(0, "IncSearch", {
  bg = "#5c6a72",
  fg = "#ffffff",
  bold = true,
})

vim.api.nvim_set_hl(0, "CurSearch", {
  bg = "#a7c080",
  fg = "#1e2326",
  bold = true,
})

vim.api.nvim_set_hl(0, "TelescopeSelection", {
  bg = "#425047",
  fg = "#d3c6aa",
  bold = true,
})

vim.api.nvim_set_hl(0, "TelescopeMatching", {
  fg = "#a7c080",
  bold = true,
})
