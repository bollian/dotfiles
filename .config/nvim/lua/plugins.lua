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
    use { 'junegunn/fzf', run = function() vim.cmd[[fzf#install()]] end }
    use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use 'airblade/vim-gitgutter'
    use 'hoob3rt/lualine.nvim'
    use 'romgrk/barbar.nvim'
    use 'lambdalisue/fern.vim'
    use 'voldikss/vim-floaterm'
    use 'mfussenegger/nvim-dap'
    use 'AckslD/nvim-neoclip.lua'
    use 'SmiteshP/nvim-gps'

    -- Git
    use 'tpope/vim-fugitive'
    use 'rbong/vim-flog'

    -- Editing functionality
    use 'b3nj5m1n/kommentary'
    use 'tpope/vim-obsession'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'windwp/nvim-autopairs'

    -- LSP support
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'kosayoda/nvim-lightbulb'
    -- use 'hrsh7th/nvim-compe'
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'quangnguyen30192/cmp-nvim-tags'
      }
    }
    use 'ray-x/lsp_signature.nvim'

    -- Language-specific plugins
    use 'simrat39/rust-tools.nvim'
    use 'arm9/arm-syntax-vim'
    use 'lervag/vimtex'

    -- Aesthetic plugins
    use 'eddyekofo94/gruvbox-flat.nvim'
    use 'sheerun/vim-polyglot'
    -- use { 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
end)
