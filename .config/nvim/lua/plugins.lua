local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- UI Elements
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
  }
  use 'airblade/vim-gitgutter'
  use 'hoob3rt/lualine.nvim'
  use 'romgrk/barbar.nvim'
  use 'lambdalisue/fern.vim'
  use 'voldikss/vim-floaterm'
  use 'AckslD/nvim-neoclip.lua'
  use 'SmiteshP/nvim-gps'
  use 'lotabout/skim'
  use 'lotabout/skim.vim'

  -- Git
  use 'tpope/vim-fugitive'
  use 'rbong/vim-flog'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Editing functionality
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'windwp/nvim-autopairs'

  -- Extra editor functionality
  use 'rmagatti/auto-session'

  -- LSP support
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'kosayoda/nvim-lightbulb'
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'quangnguyen30192/cmp-nvim-tags',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    }
  }
  use 'ray-x/lsp_signature.nvim'
  use 'mfussenegger/nvim-dap'
  use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
  use 'sakhnik/nvim-gdb'

  -- Language-specific plugins
  use 'arm9/arm-syntax-vim'
  use 'lervag/vimtex'

  -- Aesthetic plugins
  use 'eddyekofo94/gruvbox-flat.nvim'
  use 'sheerun/vim-polyglot'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
end)
