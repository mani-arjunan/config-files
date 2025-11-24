-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

treesitter.setup {
  sync_install = false,
  ignore_install = {  },
  ensure_installed = {
    "javascript",
    "typescript",
    "json",
    "lua",
    "yaml",
    "html",
    "css",
    "bash",
  },
  highlight = {
    enable = true,
  },
  auto_install = true,
  indent = {
    enable = true,
  },
}
