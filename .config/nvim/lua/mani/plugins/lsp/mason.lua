local mason = require("mason")

-- import mason-lspconfig
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")

-- enable mason and configure icons
-- with recent mason update, we don't need to install/configure any lsp, mason automatically detects
-- lsp based on language at run time.
-- But still keeping the old code commented for worst case.
mason.setup()
-- {
--   ui = {
--     icons = {
--       package_installed = "✓",
--       package_pending = "➜",
--       package_uninstalled = "✗",
--     },
--   },
-- })
--
-- mason_lspconfig.setup()
--   automatic_installation = true,
--   ensure_installed = {
--     "ts_ls",
--     "gopls",
--     "html",
--     "cssls",
--     "tailwindcss",
--     "svelte",
--     "lua_ls",
--     "graphql",
--     "emmet_ls",
--     "prismals",
--     "pyright",
--   },
-- })
--
-- mason_tool_installer.setup({
--   ensure_installed = {
--     "prettier", -- prettier formatter
--     "stylua", -- lua formatter
--     "isort", -- python formatter
--     "black", -- python formatter
--     "pylint",
--     "eslint_d",
--   },
-- })

