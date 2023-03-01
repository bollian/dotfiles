require 'telescope'
local telescopes = require 'telescope.builtin'

local function map_modes(modes, shortcut, action, options)
  local default_options = {
    silent = true,
    noremap = true
  }
  options = options or {}
  options = vim.tbl_extend('force', default_options, options)

  local vim_action = ''
  if type(action) == 'string' then
    vim_action = action
  elseif type(action) == 'function' then
    options.callback = action
  end

  for _, mode in ipairs(modes) do
    vim.api.nvim_set_keymap(mode, shortcut, vim_action, options)
  end
end

local function nmap(shortcut, action, options)
  map_modes({'n'}, shortcut, action, options)
end

-- more accessible shortcut for escape
-- also more consistent when using the terminal
map_modes({'i', 'v', 'n', 's'}, '<c-space>', '<esc>')
map_modes({'t'}, '<c-space>', '<c-\\><c-n>')

-- use normal regex when searching in normal/visual mode
nmap('/', [[/\v]], { silent = false })
-- search for highlighted text when entering search from visual mode
map_modes({ 'v' }, '/', [[y/\V<c-r>=escape(@",'/\')<cr><cr>]], { silent = false })

-- easier window navigation
local nav_modes = {'i', 'v', 'n', 's', 't'}
local remap = { noremap = false }
map_modes(nav_modes, '<c-l>', '<c-space><c-w>l', remap)
map_modes(nav_modes, '<c-h>', '<c-space><c-w>h', remap)
map_modes(nav_modes, '<c-j>', '<c-space><c-w>j', remap)
map_modes(nav_modes, '<c-k>', '<c-space><c-w>k', remap)

-- easier tab navigation
map_modes(nav_modes, '<a-l>', '<c-space><cmd>tabn<cr>', remap)
map_modes(nav_modes, '<a-h>', '<c-space><cmd>tabp<cr>', remap)

-- quick vertical movement
map_modes({'n', 'v'}, '}', '15j')
map_modes({'n', 'v'}, '{', '15k')

-- quickly switch back to previous buffer
nmap('<leader><space>', '<cmd>b#<cr>')
-- easier way to clear search highlighting
nmap('<leader>n', '<cmd>noh<cr>')
-- delete a buffer without deleting the window
nmap('<leader>q', '<cmd>Bdelete<cr>')
-- Open the file explorer in the current window
nmap('<leader>t', '<cmd>Neotree reveal<cr>')
-- Quickly splitting windows
nmap('<leader>v', '<c-w>v')
-- Searching with fzf
nmap('<leader>f', '<cmd>Files<cr>')
-- nmap('<leader>f', function() telescopes.find_files { hidden = true } end)
nmap('<leader>b', telescopes.buffers)
nmap('<leader>G', telescopes.live_grep)
nmap('<leader>g', telescopes.current_buffer_fuzzy_find)
nmap('<leader>c', telescopes.commands)
nmap('<leader>h', telescopes.help_tags)
nmap('<leader>m', telescopes.marks)
nmap('<leader>l', telescopes.jumplist)
nmap('<leader>j', function ()
  local ft_specializations = {
    markdown = telescopes.treesitter,
    html = telescopes.treesitter,
    tex = telescopes.lsp_document_symbols,
  }

  local default = function () telescopes.treesitter { default_text = ':function: ' } end
  local handler = ft_specializations[vim.bo.filetype] or default
  handler()
end)
-- nmap('<leader>j', '<cmd>lua require\'telescope.builtin\'.lsp_document_symbols()<cr>')
nmap('<leader>J', '<cmd>lua require\'telescope.builtin\'.lsp_workspace_symbols()<cr>')
nmap('<leader>y', '<cmd>Telescope neoclip<cr>')
-- Session management
nmap('<leader>ss', '<cmd>Obsess<cr>')
nmap('<leader>sd', '<cmd>Obsess!<cr>')
-- Convenient terminal window
map_modes(nav_modes, '<c-y>', '<cmd>FloatermToggle<cr>')
