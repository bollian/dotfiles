local lualine = require 'lualine'
local options = lualine.options

options.theme = 'onedark'
options.section_separators = nil
options.component_separators = nil
options.icons_enabled = false

lualine.extensions = {'fzf'}
lualine.status()
