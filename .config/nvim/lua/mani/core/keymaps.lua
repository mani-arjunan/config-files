-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- move any lines when selected
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keymap.set copy and paste selected text
keymap.set("x", "<leader>p", '"_dp')

-- keymap.set navigations in insert mode
keymap.set("i", "<C-k>", "<Up>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-h>", "<Left>")

-- keymap.set search word and replace
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- keymap.set to navigate between files
keymap.set("n", "<C-p>", ":bp <CR>")
keymap.set("n", "<C-n>", ":bn <CR>")

-- keymap.set back word from b to q
keymap.set("n", "q", "b")
keymap.set("n", "dq", "db")

-- keymap.set redo
keymap.set("n", "r", "<C-r>")

-- clear search highlights
keymap.set("n", "<Esc>", ":nohl<CR>")

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

-- diagnostic keymaps
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to Previous [D]iagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to Next [D]iagnostic message" })
keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- telescope
keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>pd", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>gr", "<Cmd>Telescope lsp_references<CR>")
keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>")
-- keymap.set("n", "gd", function()
--     require("telescope.builtin").lsp_definitions({ jump_type = "never" })
-- end, opts)

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- line travel keymap
keymap.set("n", "`", "0")
keymap.set("n", "-", "$")

keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- barbartabs keymaps

keymap.set("n", "<A-a>", "<Cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<A-d>", "<Cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
keymap.set("n", "<leader>2", "<Cmd>BufferGoto 1<CR>", opts)
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
keymap.set("n", "<A-q>", "<Cmd>BufferClose<CR>", opts)
keymap.set("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
keymap.set("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
keymap.set("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
keymap.set("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
keymap.set("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

-- format
keymap.set("n", "<C-s>", ":lua vim.lsp.buf.format()<CR>")

-- Trouble
keymap.set("n", "<leader>tt", "<Cmd>Trouble<CR>")

-- cnext and cprev
keymap.set("n", "<C-n>", "<Cmd>cnext<CR>")
keymap.set("n", "<C-p>", "<Cmd>cprev<CR>")

-- for fuzzyfinder
keymap.set("n", "<C-f>", "<Cmd>:silent !tmux neww ~/fzf_open.sh<CR>")
keymap.set("n", "<C-q>", "<Cmd>:silent !tmux neww ~/fzf_queries.sh<CR>")
keymap.set("n", "<leader>k", "<Cmd>:silent !~/tmux-kill-session.sh<CR>")
