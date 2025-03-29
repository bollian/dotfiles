return {
  'arm9/arm-syntax-vim',
  'lervag/vimtex',
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {
      dependencies_bin = {
        tinymist = 'tinymist'
      }
    },
  },
}
