local opt = vim.opt
local api = vim.api

opt.relativenumber = true
opt.nu = true
opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.hlsearch = true

opt.incsearch = true
opt.scrolloff = 999
opt.isfname:append("@-@")
opt.updatetime = 50
opt.colorcolumn = ""
opt.laststatus = 4
opt.statusline = "%f %l:%c"

api.nvim_set_hl(0, "StatusLine", { bg = "none" })
api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

opt.encoding = "utf-8"
opt.expandtab = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

opt.fileformat = 'unix'
