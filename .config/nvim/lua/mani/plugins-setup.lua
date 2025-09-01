-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- editor config
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

  -- ColorSchemes
  use("bluz71/vim-nightfly-guicolors")
  use("EdenEast/nightfox.nvim")
  use("AlexvZyl/nordic.nvim")
  use("catppuccin/nvim")
  use("Mofiqul/vscode.nvim")
  use("rose-pine/neovim")
  use("sainnhe/gruvbox-material")
  use("ilof2/posterpole.nvim")
  -- ColorSchemes

  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

  -- Toggle term
  use({
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("toggleterm").setup()
    end,
  })

  -- Trouble detector
  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({
        icones = false,
      })
    end,
  })

  -- essential plugins
  use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  use("nvim-tree/nvim-web-devicons")

  -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

  -- Telescope search
  use({ "nvim-telescope/telescope-live-grep-args.nvim" })

  -- Telescope directory specific search
  use({
    "princejoogie/dir-telescope.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("dir-telescope").setup({
        hjidden = true,
        no_ignore = false,
        show_preview = true,
      })
    end,
  })

  -- autocompletion
  use("hrsh7th/nvim-cmp") -- completion plugin
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths

  -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- managing & installing lsp servers, linters & formatters
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

  -- configuring lsp servers
  use("neovim/nvim-lspconfig") -- easily configure language servers
  use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  }) -- enhanced lsp uis
  use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

  -- formatting & linting
  use("stevearc/conform.nvim")
  use("WhoIsSethDaniel/mason-tool-installer.nvim")

  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- AST

  use({
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  })

  -- auto closing
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- git integration
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

  -- primeagen vimbegood game(helpful to get used to vim keystrokes)
  use("ThePrimeagen/vim-be-good")

  -- Git plugin
  use("tpope/vim-fugitive")

  -- Function fold
  use("kevinhwang91/promise-async")
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
  use({
    "ibhagwan/fzf-lua",
    -- optional for icon support
    requires = { "nvim-tree/nvim-web-devicons" },
  })
  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })

  use("xiyaowong/transparent.nvim")

  -- image preview
  use("adelarsq/image_preview.nvim")

  use({
    "~/.config/nvim/custom-plugin/worktree",
    config = function()
      require("worktree").setup()
    end,
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
