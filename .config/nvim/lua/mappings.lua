local o = vim.o
local wo = vim.wo
local bo = vim.bo

local function map_modes(modes, shortcut, action, options)
    local default_options = {
        silent = true,
        noremap = true
    }
    options = options or {}
    options = vim.tbl_extend('force', default_options, options)
    for _, mode in ipairs(modes) do
        vim.api.nvim_set_keymap(mode, shortcut, action, options)
    end
end

local function nmap(shortcut, action, options)
    map_modes({'n'}, shortcut, action, options)
end

-- more accessible shortcut for escape
-- also more consistent when using the terminal
map_modes({'i', 'v', 'n', 's'}, '<c-space>', '<esc>')
map_modes({'t'}, '<c-space>', '<c-\\><c-n>')

-- easier window navigation
local nav_modes = {'i', 'v', 'n', 's', 't'}
local remap = {noremap = false}
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
nmap('<leader>q', '<cmd>BufferClose<cr>')
-- Open the file explorer in the current window
nmap('<leader>t', '<cmd>Fern . -reveal=%<cr>')
-- Quickly splitting windows
nmap('<leader>v', '<C-w>v')
-- Searching with fzf
nmap('<leader>f', '<cmd>Files<cr>')
-- nmap('<leader>f', '<cmd>lua require\'telescope.builtin\'.find_files{}<cr>')
nmap('<leader>b', '<cmd>Buffers<cr>')
nmap('<leader>g', '<cmd>Rg<cr>')
nmap('<leader>c', '<cmd>Commands<cr>')
nmap('<leader>h', '<cmd>Helptags<cr>')
nmap('<leader>m', '<cmd>Marks<cr>')
nmap('<leader>j', '<cmd>lua require\'telescope.builtin\'.lsp_document_symbols{}<cr>')
nmap('<leader>J', '<cmd>lua require\'telescope.builtin\'.lsp_workspace_symbols{}<cr>')
nmap('<leader>y', '<cmd>Telescope neoclip<cr>')
-- Session management
nmap('<leader>ss', '<cmd>Obsess<cr>')
nmap('<leader>sd', '<cmd>Obsess!<cr>')
-- Convenient terminal window
map_modes(nav_modes, '<c-y>', '<cmd>FloatermToggle<cr>')
