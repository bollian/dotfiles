return {
  {
    'eddyekofo94/gruvbox-flat.nvim',
    priority = 100,
    config = function()
      vim.g.gruvbox_flat_style = 'hard'
      vim.cmd 'colorscheme gruvbox-flat'
    end
  },
  { 'nvim-treesitter/nvim-treesitter', config = function() vim.fn.execute(':TSUpdate') end },
  'nvim-treesitter/playground',

  -- Language-specific plugins
  'arm9/arm-syntax-vim',
  'lervag/vimtex',
}
