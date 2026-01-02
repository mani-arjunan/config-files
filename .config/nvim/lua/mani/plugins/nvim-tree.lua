-- -- import nvim-tree plugin safely
-- local setup, nvimtree = pcall(require, "nvim-tree")
-- if not setup then
--   return
-- end
--
-- -- recommended settings from nvim-tree documentation
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
--
-- -- change color for arrows in tree to light blue
-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
--
-- -- configure nvim-tree
-- nvimtree.setup({
--   -- disable window_picker for
--   -- explorer to work well with
--   -- window splits
--   update_focused_file = {
--     enable = true,
--     update_root = true,
--     ignore_list = { "TelescopePrompt" }, -- prevent collapse on telescope
--   },
--   actions = {
--     open_file = {
--       window_picker = {
--         enable = false,
--       },
--     },
--   },
--   -- 	git = {
--   -- 		ignore = false,
--   -- 	},
-- })
--
-- -- open nvim-tree on setup
-- local function open_nvim_tree(data)
--   -- buffer is a [No Name]
--   local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
--
--   -- buffer is a directory
--   local directory = vim.fn.isdirectory(data.file) == 1
--
--   if not no_name and not directory then
--     return
--   end
--
--   -- change to the directory
--   if directory then
--     vim.cmd.cd(data.file)
--   end
--
--   -- open the tree
--   require("nvim-tree.api").tree.open()
-- end
--
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
--
--

-- import nvim-tree plugin safely
local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
  return
end

-- disable netrw (recommended)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optional: change indent marker color
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

-- =========================
-- nvim-tree setup
-- =========================
nvimtree.setup({
  -- 🚫 NEVER let nvim-tree touch cwd
  sync_root_with_cwd = false,
  respect_buf_cwd = false,
  update_cwd = false,

  -- follow current file WITHOUT re-rooting
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

-- =========================
-- open tree on startup (NO cd)
-- =========================
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

-- =========================
-- keep tree in sync with navigation (gd / <C-o>)
-- =========================
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local api = require("nvim-tree.api")

    -- do nothing if tree is closed
    if not require("nvim-tree.view").is_visible() then
      return
    end

    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    if file == "" then return end

    -- reveal current file without changing root or cwd
    api.tree.find_file({
      open = true,
      focus = false,
    })
  end,
})
