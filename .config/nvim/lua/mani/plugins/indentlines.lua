-- import indentlines safely
local ibl_setup, ibl = pcall(require, "ibl")
if not ibl_setup then
  return
end

ibl.setup({
  indent = {
    char = "│", -- Customize the character for indent lines
  },
  scope = {
    enabled = true, -- Enable scope highlighting for the cursor
    show_start = false, -- Don't highlight the start of the context
    show_end = false, -- Don't highlight the end of the context
  },
})
