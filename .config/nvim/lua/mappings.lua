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
nmap('<leader>tt', '<cmd>Neotree reveal toggle<cr>')
nmap('<leader>tf', '<cmd>Neotree reveal toggle<cr>')
nmap('<leader>tb', '<cmd>Neotree reveal toggle source=buffers<cr>')
nmap('<leader>ts', '<cmd>Neotree position=right toggle source=document_symbols<cr>')
-- Quickly splitting windows
nmap('<leader>v', '<c-w>v')
-- Open previous telescope
nmap('<leader>o', telescopes.resume)
-- Searching with telescope
nmap('<leader>f', function() telescopes.find_files { hidden = true } end)
nmap('<leader>F', telescopes.find_files)
nmap('<leader>b', telescopes.buffers)
nmap('<leader>gf', telescopes.live_grep)
nmap('<leader>gg', telescopes.current_buffer_fuzzy_find)
nmap('<leader>gb', function()
  telescopes.live_grep {
    grep_open_files = true,
  }
end)
nmap('<leader>c', telescopes.commands)
nmap('<leader>m', telescopes.marks)
nmap('<leader>l', telescopes.jumplist)
nmap('<leader>j', function ()
  local function link_and_ts(opts)
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_mark(0, "'", pos[1], pos[2], {})
    telescopes.treesitter(opts)
  end

  local ft_specializations = {
    markdown = link_and_ts,
    html = link_and_ts,
    tex = telescopes.lsp_document_symbols,
    cpp = telescopes.lsp_document_symbols,
    c = telescopes.lsp_document_symbols,
    rust = telescopes.lsp_document_symbols,
    typst = telescopes.lsp_document_symbols,
  }

  local default = function() link_and_ts { default_text = ':function: ' } end
  local handler = ft_specializations[vim.bo.filetype] or default
  handler()
end)
nmap('<leader>J', telescopes.lsp_dynamic_workspace_symbols)
nmap('<leader>y', '<cmd>Telescope neoclip<cr>')
-- Open matching header/source file based on current file name
nmap('<leader>h', function()
  local buf_path = vim.api.nvim_buf_get_name(0)
  local extensions = {
    ['.cpp'] = {'.hpp', '.h'},
    ['.cxx'] = {'.hxx', '.h'},
    ['.cc'] = {'.hh', '.h'},
    ['.c'] = {'.h'},
    ['.h'] = {'.c', '.cpp', '.cc', '.cxx'},
    ['.hpp'] = {'.cpp'},
    ['.hxx'] = {'.cxx'},
    ['.hh'] = {'.cc'},
    ['.js'] = {'.d.ts'},
    ['.d.ts'] = {'.js'},
  }

  for from, to in pairs(extensions) do
    if buf_path:match(from .. '$') then
      local start = string.sub(buf_path, 1, #buf_path - #from)
      for _, new_ext in pairs(to) do
        local new_fpath = start .. new_ext
        if vim.fn.filereadable(new_fpath) == 1 then
          vim.cmd('e ' .. new_fpath)
          return
        end
      end
    end
  end

  vim.notify('Matching source/header not found!', vim.log.levels.INFO)
end)

vim.api.nvim_create_user_command('Help', telescopes.help_tags, {})
