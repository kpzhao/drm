local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)

-- it is recommended to put impatient.nvim before any other plugins
--  use { "lewis6991/impatient.nvim", config = [[require('impatient')]] }

  use { "wbthomason/packer.nvim" } -- Have packer manage itself

-- bufferline
  use {"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" }

-- comment 
  use { "numToStr/Comment.nvim" }

-- Colorschemes
  use { "folke/tokyonight.nvim" }
--  use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }
  use { "ellisonleao/gruvbox.nvim" , requires = "rktjmp/lush.nvim" }
  use 'shaunsingh/nord.nvim'  -- nord theme

-- dashboard
  use {'glepnir/dashboard-nvim'}

-- nvim-cmp
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
	use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
	use { "hrsh7th/cmp-nvim-lsp" }
	use { "hrsh7th/cmp-nvim-lua" }
	-- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

-- lspconfig
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }

-- lualine
  use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }

-- nvim-tree
  use { "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" }

-- treesitter
  use {
        "nvim-treesitter/nvim-treesitter",
        run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
      }

-- telescope
  use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} }
      }
  use 'nvim-telescope/telescope-media-files.nvim'

-- WhichKey
  use { "folke/which-key.nvim" }
	-- Telescope
--	use { "nvim-telescope/telescope.nvim", commit = "76ea9a898d3307244dce3573392dcf2cc38f340f" }

	-- Treesitter
--	use {
--		"nvim-treesitter/nvim-treesitter",
--		commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
--	}

	-- Git
--	use { "lewis6991/gitsigns.nvim", commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2" }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
