require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    elixir = { "mix" },
    rust = { "rustfmt" },
    python = { "pylsp" }
  },
})

