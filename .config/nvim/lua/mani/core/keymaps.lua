-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

keymap.set("n", "cq", "cb")

-- move any lines when selected
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- map copy and paste selected text
keymap.set("x", "<leader>p", '"_dp')

-- map navigations in insert mode
keymap.set("i", "<C-k>", "<Up>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-h>", "<Left>")

-- map search word and replace
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- map tmux

-- map back word from b to q
keymap.set("n", "q", "b")
keymap.set("n", "dq", "db")

-- map redo
keymap.set("n", "r", "<C-r>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- format
keymap.set("n", "<C-S-k>", "<cmd>lua vim.lsp.buf.format()<cr>")

-- telescope
keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>") -- selects directory that we need to search string
keymap.set("n", "<leader>pd", "<cmd>Telescope dir find_files<CR>") -- selects directory that we need to search files
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>fm", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>") -- live grep search

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- line travel keymap
keymap.set("n", "`", "0")
keymap.set("n", "-", "$")

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- window splitting
keymap.set("n", "<leader>v", "<cmd>vsplit<cr>")
keymap.set("n", "<leader>h", "<cmd>split<cr>")

-- clear search highlight
keymap.set("n", "<leader>cs", "<cmd>noh<cr>")

-- barbar keyaps
local opts = { noremap = true, silent = true }

keymap.set("n", "<C-Left>", "<Cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<C-Right>", "<Cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
keymap.set("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
keymap.set("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
keymap.set("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
keymap.set("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
keymap.set("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
keymap.set("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
keymap.set("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
keymap.set("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
keymap.set("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
keymap.set("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)
keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
keymap.set("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
keymap.set("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
keymap.set("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
keymap.set("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
keymap.set("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

-- formatter
keymap.set("n", "<C-s>", ":lua vim.lsp.buf.format()<CR>")

keymap.set("n", "<leader>tt", "<Cmd>Trouble<CR>")

-- cnext and cprev
keymap.set("n", "<C-n>", "<Cmd>cnext<CR>")
keymap.set("n", "<C-p>", "<Cmd>cprev<CR>")

