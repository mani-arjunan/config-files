vim.opt.nu = true
vim.opt.relativenumber = true

-- -- vim.opt.tabstop = 10
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth  = 4
-- vim.opt.expandtab = true
--
-- vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 30
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""

vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_disable_terminal_colors = 1
vim.g.gruvbox_contrast = 'soft'
vim.g.gruvbox_transparent_mode = 1
