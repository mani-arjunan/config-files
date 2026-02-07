-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

-- use g- and g+ for undo and redo
-- keymap.set("n", "u", "g-")
-- keymap.set("n", "r", "g+")

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "cq", "cb")

-- move any lines when selected
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keymap.set copy and paste selected text
keymap.set("x", "<leader>p", '\"_dP')

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
keymap.set("n", "b", "q")
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
keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>")
keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>")
keymap.set("n", "<leader>fr", function()
  local api = require("nvim-tree.api")
  local file = vim.api.nvim_buf_get_name(0)

  if not require("nvim-tree.view").is_visible() then
    api.tree.open()
  end

  if file ~= "" then
    api.tree.change_root(vim.fn.fnamemodify(file, ":p:h"))
  end
end)

keymap.set("n", "<leader>pr", function()
  local api = require("nvim-tree.api")
  local root = vim.g.nvim_startup_root

  if not root or root == "" then
    return
  end

  if not require("nvim-tree.view").is_visible() then
    api.tree.open()
  end

  api.tree.change_root(root)
end)

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]
keymap.set("n", "<leader>gf", "<cmd>Gvdiff :0<cr>")

-- line travel keymap
keymap.set("n", "`", "0")
keymap.set("n", "-", "$")
keymap.set("n", "de", "d$")
keymap.set("n", "ce", "c$")

keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- keymap.set("n", "<c-s>", ":lua vim.lsp.buf.format()<cr>")
keymap.set("n", "<c-s>", ":lua require('conform').format()<cr>")

-- Trouble
keymap.set("n", "<leader>tt", "<Cmd>Trouble<CR>")

-- cnext and cprev
keymap.set("n", "<C-n>", "<Cmd>cnext<CR>")
keymap.set("n", "<C-p>", "<Cmd>cprev<CR>")

-- for fuzzyfinder
keymap.set("n", "<C-f>", "<Cmd>:silent !tmux neww ~/fzf_open.sh<CR>")
keymap.set("n", "<C-q>", "<Cmd>:silent !tmux neww ~/fzf_queries.sh<CR>")
keymap.set("n", "<leader>k", "<Cmd>:silent !~/tmux-kill-session.sh<CR>")

-- some actions on lsp current buffer
keymap.set("n", "<leader>ca", function () vim.lsp.buf.code_action() end, opts)
keymap.set("n", "<leader>rn", function () vim.lsp.buf.rename() end, opts)

-- undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- git-worktree remap
keymap.set("n", "<leader>gw", function()
  vim.cmd("Worktrees")
end)

keymap.set("n", "<leader>gwd", function()
  vim.cmd("WorktreesDelete")
end)

keymap.set("n", "<leader>gwf", function()
  vim.cmd("WorktreesFetch")
end)

vim.filetype.add({
  pattern = {
    ["Jenkinsfile.*"] = "groovy",
  },
})

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
