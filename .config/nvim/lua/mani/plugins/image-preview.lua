-- import image preview plugin safely
local setup, ip = pcall(require, "image_preview")
if not setup then
  return
end

ip.setup({})
