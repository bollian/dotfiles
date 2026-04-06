return {
  { -- for copilot avante provider
    'github/copilot.vim',
  },
  {
    'yetone/avante.nvim',
    --@module avante
    --@type avante.Config
    opts = {
      provider = "copilot",
      providers = {
        copilot = {
        }
      }
    },
    build = vim.fn.has('win32') ~= 0
      and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      or 'make BUILD_FROM_SOURCE=true',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'folke/snacks.nvim',
    },
  }
}
