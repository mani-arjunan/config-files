-- import formatter safely
local formatter_setup, formatter = pcall(require, "conform")
if not formatter_setup then
  return
end

-- configure conform formatter
formatter.setup({
  formatters_by_ft = {
    lua = { "styula" },
    javascript = { { "prettierd", "prettier" } }
  }
})
