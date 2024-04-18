local hydra = require('hydra.statusline')
local lsp_status = require('lsp-status')

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

local vim_mode = {
  'mode',
  cond = function() return not hydra.is_active() end
}

local hydra_mode = {
  hydra.get_name,
  cond = function() return hydra.is_active() end,
  color = function()
    return { fg = 'black', bg = hydra.get_color() }
  end
}

local function filetype_or_lsp()
  local servers = vim.lsp.buf_get_clients()
  for _, server in ipairs(servers) do
    local ok, server_name = pcall(function()
      return server.config.name
    end)

    if ok then
      local messages = lsp_status.messages()
      local progress = ''
      if #messages > 0 then
        local latest = messages[#messages]
        progress = ' ' .. tostring(latest.percentage) .. '%% ' .. tostring(latest.title)
      end
      return server_name .. progress
    end
  end
  return vim.bo.filetype or ''
end

require('lualine').setup {
  options = {
    theme = 'gruvbox-flat',
    section_separators = {},
    component_separators = {},
    icons_enabled = false,
    globalstatus = true
  },
  sections = {
    lualine_a = {vim_mode, hydra_mode},
    lualine_b = {diff, 'branch'},
    lualine_c = {diagnostics, 'filename'},
    lualine_x = {'encoding', 'fileformat', filetype_or_lsp},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  extensions = {'fugitive', 'fzf'}
}
