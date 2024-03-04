-- import indentlines safely
local ibl_setup, ibl = pcall(require, "ibl")
if not ibl_setup then
  return
end

-- configure ibl
ibl.setup({
  scope = { enabled = false }
})
