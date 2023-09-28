return {
  { 'airblade/vim-gitgutter',
    init = function()
      -- display a colored line for git diff
      vim.g.gitgutter_sign_added = '│'
      vim.g.gitgutter_sign_modified = '│'
      vim.g.gitgutter_sign_removed = '_'
      vim.g.gitgutter_sign_modified_removed = '│_'

      -- default max number of signs is 500. causes problems with large files
      vim.g.gitgutter_max_signs = 1000
    end,
  },
  'tpope/vim-fugitive',
  'rbong/vim-flog',
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
}
