local diagnostics = {
  'diagnostics',
  sources = {'nvim_lsp'},
  color_error = '#e06c75',
  color_warn = '#e5c07b'
}

local diff = {
  'diff',
  color_added = '#98c379',
  color_removed = '#e06c65'
}

function filetype_or_lsp()
  local servers = vim.lsp.buf_get_clients()
  for _, server in ipairs(servers) do
    local ok, server_name = pcall(function()
      return server.config.name
    end)
    if ok then
      return server_name
    end
  end
  return vim.bo.filetype or ''
end

local lualine = require 'lualine'.setup {
  options = {
    theme = 'gruvbox-flat',
    section_separators = {},
    component_separators = {},
    icons_enabled = false
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {diff, 'branch'},
    lualine_c = {diagnostics, 'filename'},
    lualine_x = {'encoding', 'fileformat', filetype_or_lsp},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  extensions = {'fugitive', 'fzf'}
}
