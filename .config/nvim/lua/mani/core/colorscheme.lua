-- local ok, tokyo = pcall(require, "tokyonight")
-- if not ok then
--   print("tokyonight not found!")
--   return
-- end
--
-- tokyo.setup({
--   style = "storm",
--   transparent = true,
--   terminal_colors = true,
--   styles = {
--     comments = { italic = false },
--     keywords = { italic = false },
--     functions = {},
--     variables = {},
--   },
-- })

vim.cmd.colorscheme("gruvbox-material")

vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight MsgArea guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
]]

vim.cmd [[
  highlight NvimTreeNormal guibg=NONE ctermbg=NONE
  highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
  highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
]]
