local telescope = require 'telescope'
local telescopes = require 'telescope.builtin'

local default_tscope_theme = {
  theme = 'minimalism contrasting',

  results_title = false,
  sorting_strategy = 'descending',
  border = true,

  layout_strategy = 'horizontal',
  -- layout_config = {
  --
  -- },
  borderchars = {
    prompt = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
    results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  }
}

local function map(modes, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(modes, lhs, rhs, opts)
end

-- Create a mapping only in normal mode
local function nmap(lhs, rhs, desc, opts)
  map('n', lhs, rhs, desc, opts)
end

-- Create a mapping for a telescope picker that copies the current selection
-- into the search box if currently in visual mode
local function tscope_vfill_map(lhs, rhs, desc, opts)
  map('n', lhs, rhs, desc, opts)
  map('v', lhs, function()
    -- copy selection to register because it's the only way to access it
    -- since '< and '> aren't set yet
    vim.api.nvim_feedkeys('"vy', 'n', 'true')
    local selected = vim.fn.getreg('v')
    rhs { default_text = selected }
  end, desc, opts)
end

local function find_all_files()
  telescopes.find_files {
    hidden = true,
    no_ignore = true,
    no_ignore_parent = true,
  }
end

---@diagnostic disable-next-line: unused-local
vim.api.nvim_create_user_command('Files', function(invocation)
  telescopes.find_files()
end, {})

---@diagnostic disable-next-line: unused-local
vim.api.nvim_create_user_command('AllFiles', function(invocation)
  find_all_files()
end, {})

-- more accessible shortcut for escape
-- also more consistent when using the terminal
map({'i', 'v', 'n', 's'}, '<c-space>', '<esc>', 'Quick Escape')
map({'t'}, '<c-space>', '<c-\\><c-n>', 'Quick Escape')

-- use normal regex when searching in normal/visual mode
nmap('/', [[/\v]], nil, { silent = false })
-- search for highlighted text when entering search from visual mode
map({ 'v' }, '/', [[y/\V<c-r>=escape(@",'/\')<cr><cr>]], nil, { silent = false })

-- easier window navigation
local nav_modes = {'i', 'v', 'n', 's', 't'}
local remap = { remap = true }
map(nav_modes, '<c-l>', '<c-space><c-w>l', 'Move to Window Right', remap)
map(nav_modes, '<c-h>', '<c-space><c-w>h', 'Move to Window Left', remap)
map(nav_modes, '<c-j>', '<c-space><c-w>j', 'Move to Window Down', remap)
map(nav_modes, '<c-k>', '<c-space><c-w>k', 'Move to Window Up', remap)

-- easier tab navigation
map(nav_modes, '<a-l>', '<c-space><cmd>tabn<cr>', 'Move to Tab Right', remap)
map(nav_modes, '<a-h>', '<c-space><cmd>tabp<cr>', 'Move to Tab Left', remap)

-- quick vertical movement
map({'n', 'v'}, '}', '15j')
map({'n', 'v'}, '{', '15k')

nmap('<leader><space>', '<cmd>b#<cr>', 'Switch to Previous Buffer')
nmap('<leader>n', '<cmd>noh<cr>', 'Clear Highlighting')
nmap('<leader>q', '<cmd>Bdelete<cr>', 'Delete Current Buffer')
nmap('<leader>t', '<cmd>Neotree reveal<cr>', 'Open File Explorer')
map(nav_modes, '<c-y>', '<cmd>FloatermToggle<cr>', 'Toggle Floating Terminal')
nmap('<leader>v', '<c-w>v', 'Split View Vertically')
nmap('<leader>f', telescopes.find_files, 'Find File')
nmap('<leader>F', find_all_files, 'Find File, no ignore')
nmap('<leader>o', telescopes.resume, 'Previous Telescope')
nmap('<leader>b', telescopes.buffers, 'Find Buffer')
tscope_vfill_map('<leader>G', telescopes.live_grep, 'Live Global Grep')
tscope_vfill_map('<leader>g', telescopes.current_buffer_fuzzy_find, 'Live Buffer Grep')
nmap('<leader>c', telescopes.commands, 'Search Commands')
nmap('<leader>h', telescopes.help_tags, 'Search Help')
nmap('<leader>m', telescopes.marks, 'Search Marks')
nmap('<leader>l', function() telescopes.jumplist(default_tscope_theme) end, 'Search Jump List')
tscope_vfill_map('<leader>y', telescope.extensions.neoclip.default, 'Search Yanked Text')
tscope_vfill_map('<leader>J', telescopes.lsp_dynamic_workspace_symbols, 'Go to Workspace Symbol')
tscope_vfill_map('<leader>j', function(opts)
---@diagnostic disable-next-line: redefined-local
  local function telescope_treesitter_functions(opts)
    opts.default_text = ':function: ' .. (opts.default_text or '')
    telescopes.treesitter(opts)
  end

  local function lsp_with_ts_fallback()
    local buffer = vim.api.nvim_get_current_buf()
    local lang_servers = vim.lsp.get_active_clients { bufnr = buffer }
    if #lang_servers > 0 then
      telescopes.lsp_document_symbols(opts)
    else
      telescope_treesitter_functions(opts)
    end
  end

  local ft_specializations = {
    markdown = telescopes.treesitter,
    html = telescopes.treesitter,
    tex = telescopes.lsp_document_symbols,
  }

  local handler = ft_specializations[vim.bo.filetype] or lsp_with_ts_fallback
  handler()
end, 'Go to Buffer Symbol')
-- Convenient terminal window
