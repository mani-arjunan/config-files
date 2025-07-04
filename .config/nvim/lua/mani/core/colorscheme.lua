vim.cmd.colorscheme("gruvbox-material")

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

vim.cmd([[
  highlight CursorLine guibg=#2c304a
  highlight Visual guibg=#2c304a
  highlight NvimTreeCursorLine guibg=#2c304a
]])
