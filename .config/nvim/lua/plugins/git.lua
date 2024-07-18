return {
  { 'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      kind = "split_above",
      commit_editor = {
        kind = "auto"
      },
    }
  },
  { 'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
      }
    },
  },
  'tpope/vim-fugitive',
  'rbong/vim-flog',
  { 'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      use_icons = false,
    }
  },
}
