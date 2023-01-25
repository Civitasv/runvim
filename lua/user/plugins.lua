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
      return require("packer.util").float({ border = "single" })
    end,
  },
})

-- Install Plugins
return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Have packer manage itself

  -- [[ Basic ---------------------------------------
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in neovim to improve startup time
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("numToStr/Comment.nvim") -- Easily comment stuff
  use("goolord/alpha-nvim") -- A fast and fully customizable greeter for neovim
  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
  use("moll/vim-bbye") -- Bdelete command
  -- Retrieve startup time
  use("dstein64/vim-startuptime")
  ------------------------------------------------]]

  -- [[ Useful ---------------------------------------
  use("kyazdani42/nvim-tree.lua") -- tree view
  use("nvim-lualine/lualine.nvim") -- status line
  use("akinsho/toggleterm.nvim") -- terminal
  use("folke/which-key.nvim") -- vim which key
  use("folke/todo-comments.nvim") -- Todo comments
  -- Git
  use("lewis6991/gitsigns.nvim")
  use("tpope/vim-fugitive")
  use("CRAG666/code_runner.nvim")
  use("editorconfig/editorconfig-vim") -- editor config
  use("phaazon/hop.nvim")
  use("kylechui/nvim-surround") -- Surround
  ------------------------------------------------]]

  -- [[ Completion ---------------------------------------
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
  ------------------------------------------------]]

  -- [[ LSP ---------------------------------------
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use("filipdutescu/renamer.nvim") -- vscode like renamer
  use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }) -- show diagnostics using virtual lines
  use("p00f/clangd_extensions.nvim") -- clangd extension, some good stuff
  -- Neovim config development
  use("folke/neodev.nvim")
  -- rust, rust, it's rust!
  use("simrat39/rust-tools.nvim")
  use {
    "saecki/crates.nvim",
    tag = "v0.3.0",
  }
  -- hlargs
  use { "m-demare/hlargs.nvim" }
  ------------------------------------------------]]

  -- [[ DAP ---------------------------------------
  use("mfussenegger/nvim-dap")
  use("theHamsta/nvim-dap-virtual-text")
  use("rcarriga/nvim-dap-ui")
  use("rcarriga/cmp-dap")
  ------------------------------------------------]]

  -- use("Civitasv/cmake-tools.nvim")

  -- [[ Telescope ---------------------------------------
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-ui-select.nvim")
  use("nvim-telescope/telescope-dap.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" })
  ------------------------------------------------]]

  -- [[ Docs ---------------------------------------
  -- Markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })
  use("godlygeek/tabular")
  use("preservim/vim-markdown")
  -- Latex
  use("lervag/vimtex")
  ------------------------------------------------]]

  -- [[ UI ---------------------------------------
  use("rcarriga/nvim-notify") -- Notify UI
  use("lukas-reineke/indent-blankline.nvim") -- Indent line
  -- Colorschemes
  use("projekt0n/github-nvim-theme")
  use({ "catppuccin/nvim", as = "catppuccin" })
  use("bluz71/vim-nightfly-colors")
  -- Icons
  use("kyazdani42/nvim-web-devicons")
  -- Vim css color
  use("ap/vim-css-color")
  -- Treesitter, for syntax color
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  -- Fold Code
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
  ------------------------------------------------]]

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
