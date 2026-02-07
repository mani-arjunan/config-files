local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvimtree.setup({
  sync_root_with_cwd = false,
  respect_buf_cwd = false,
  update_cwd = false,

  update_focused_file = {
    enable = true,
    update_root = false, -- 🔑 CRITICAL
    ignore_list = { "TelescopePrompt" },
  },

  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})

local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1
  if directory then
    require("nvim-tree.api").tree.open({ path = data.file })
  else
    require("nvim-tree.api").tree.open()
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = open_nvim_tree,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local api = require("nvim-tree.api")

    if not require("nvim-tree.view").is_visible() then
      return
    end

    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    if file == "" then return end

    api.tree.find_file({
      open = true,
      focus = false,
    })
  end,
})
