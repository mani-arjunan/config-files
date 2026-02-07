vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_disable_terminal_colors = 1
vim.g.gruvbox_contrast = 'soft'
vim.g.gruvbox_transparent_mode = 1

vim.opt.foldcolumn = "0"
vim.opt.laststatus = 0
vim.opt.fillchars:append({ eob = " " })

local function get_startup_root()
  local argv = vim.fn.argv()

  -- if nvim was started with a path
  if #argv > 0 then
    local path = vim.fn.fnamemodify(argv[1], ":p")
    if vim.fn.isdirectory(path) == 1 then
      return path
    end
  end

  -- fallback to cwd
  return vim.fn.getcwd(-1, -1)
end

vim.g.nvim_startup_root = get_startup_root()

