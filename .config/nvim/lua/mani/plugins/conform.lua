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
  formatters = {
    eslint_d = {
      command = "eslint_d",
      -- Override cwd to find config in monorepos / nested projects
      cwd = require("conform.util").root_file({
        "eslint.config.mjs",
        "eslint.config.js",
        ".eslintrc.js",
        ".eslintrc.json",
        "package.json",
      }),
    },
  },
  default_format_opts = {
    timeout_ms = 5000,
  },
})

