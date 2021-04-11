local diagnostics = {
  'diagnostics',
  sources = {'nvim_lsp'},
  color_error = '#e06c75',
  color_warn = '#e5c07b'
}
local lualine = require 'lualine'.setup {
  options = {
    theme = 'onedark',
    section_separators = {},
    component_separators = {},
    icons_enabled = false
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff', 'branch'},
    lualine_c = {diagnostics, 'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  extensions = {'fugitive', 'fzf'}
}
