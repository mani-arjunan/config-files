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
    use("editorconfig/editorconfig-vim")
    -- packer can manage itself
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

    -- Colorschemes
    use("bluz71/vim-nightfly-guicolors")
    use("EdenEast/nightfox.nvim")
    -- Colorschemes

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

    -- install without yarn or npm

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })

    -- essential plugins
    use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)

    -- commenting with gc
    use("numToStr/Comment.nvim")

    -- file explorer
    use("nvim-tree/nvim-tree.lua")

    use("nvim-tree/nvim-web-devicons")

    -- statusline
    use("nvim-lualine/lualine.nvim")

    -- fuzzy finding w/ telescope
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })
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
    -- use({
    --   "glepnir/lspsaga.nvim",
    --   branch = "main",
    --   requires = {
    --     { "nvim-tree/nvim-web-devicons" },
    --     { "nvim-treesitter/nvim-treesitter" },
    --   },
    -- })
    -- -- enhanced lsp uis
    use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

    -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

    -- treesitter configuration
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    -- auto closing
    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

    -- git integration
    use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

    -- tabs
    use("romgrk/barbar.nvim")

    -- primeagen vimbegood game(helpful to get used to vim keystrokes)
    use("ThePrimeagen/vim-be-good")

    -- formatter
    use({
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup()
        end,
    })

    -- IndentLines
    use("lukas-reineke/indent-blankline.nvim")

    use("kevinhwang91/promise-async")
    use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

    -- Git plugin
    use("tpope/vim-fugitive")

    -- ColorSchemes
    use("ellisonleao/gruvbox.nvim")
    use("rebelot/kanagawa.nvim")
    use("catppuccin/nvim")
    use("folke/tokyonight.nvim")
    use("Mofiqul/vscode.nvim")

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
    use("editorconfig/editorconfig-vim")
    -- packer can manage itself
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

    -- Colorschemes
    use("bluz71/vim-nightfly-guicolors")
    use("EdenEast/nightfox.nvim")
    -- Colorschemes

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

    -- install without yarn or npm

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })

    -- essential plugins
    use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)

    -- commenting with gc
    use("numToStr/Comment.nvim")

    -- file explorer
    use("nvim-tree/nvim-tree.lua")

    use("nvim-tree/nvim-web-devicons")

    -- statusline
    use("nvim-lualine/lualine.nvim")

    -- fuzzy finding w/ telescope
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })
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
    -- use({
    --   "glepnir/lspsaga.nvim",
    --   branch = "main",
    --   requires = {
    --     { "nvim-tree/nvim-web-devicons" },
    --     { "nvim-treesitter/nvim-treesitter" },
    --   },
    -- })
    -- -- enhanced lsp uis
    use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

    -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

    -- treesitter configuration
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    -- auto closing
    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

    -- git integration
    use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

    -- tabs
    use("romgrk/barbar.nvim")

    -- primeagen vimbegood game(helpful to get used to vim keystrokes)
    use("ThePrimeagen/vim-be-good")

    -- formatter
    use({
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup()
        end,
    })

    -- IndentLines
    use("lukas-reineke/indent-blankline.nvim")

    -- Git plugin
    use("tpope/vim-fugitive")

    -- ColorSchemes
    use("ellisonleao/gruvbox.nvim")
    use("rebelot/kanagawa.nvim")
    use("catppuccin/nvim")
    use("folke/tokyonight.nvim")
    use("Mofiqul/vscode.nvim")

    -- Codeium
    use("Exafunction/codeium.vim")
                
    -- function fold
    use("kevinhwang91/promise-async")
    use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

    if packer_bootstrap then
        require("packer").sync()
    end
end)

    -- function fold

    if packer_bootstrap then
        require("packer").sync()
    end
end)
