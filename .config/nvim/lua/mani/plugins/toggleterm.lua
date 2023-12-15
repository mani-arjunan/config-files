local toggle_term_status, toggleterm = pcall(require, "toggleterm")
if not toggle_term_status then
  return
end

local toggle_term_terminal_status, toggletermterminal = pcall(require, "toggleterm.terminal")
if not toggle_term_terminal_status then
  return
end

toggleterm.setup({
  size = 20,
  hide_number = true,
  shade_filetypes = {},
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  close_on_exit = true,
  shell = vim.o.shell,
  direction = "float",
  shade_terminals = true,
  float_opts = {
    border = "curved",
    winblend = 0
  },
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


local lazygit = toggletermterminal.Terminal:new({ cmd = "lazygit", hidden = false })
local node = toggletermterminal.Terminal:new({ cmd = "node", hidden = false })
local terminal = toggletermterminal.Terminal:new({ hidden = false })

function _node_toggle()
  node:toggle()
end

function _lazygit_toggle()
  lazygit:toggle()
end

function _terminal_toggle()
  terminal:toggle()
end

vim.api.nvim_set_keymap("n","<leader>lg","<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>lua _node_toggle()<CR>", { noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>lua _terminal_toggle()<CR>", { noremap = true, silent = true })

