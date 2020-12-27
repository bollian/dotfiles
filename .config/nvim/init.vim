let g:polyglot_disabled = ['latex']

" First, setup plugins
call plug#begin('~/.local/share/nvim/plugged')
" UI Elements
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'vim-airline/vim-airline'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

" Editing functionality
Plug 'moll/vim-bbye'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Language IDE support
Plug 'arm9/arm-syntax-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/telescope.nvim'
" Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/plenary.nvim' " dependency for telescope
Plug 'nvim-lua/popup.nvim' " dependency for telescope

" Aesthetic plugins
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
call plug#end()

" No automatic word-wrapping
set tw=0

" Only redraw when necessary (makes macros run faster)
set lazyredraw

" Tab configuration
set tabstop=4 softtabstop=-1 expandtab shiftwidth=4 smarttab

" Show whitespace
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

" Line number gutter configuration
set number relativenumber

" Show when I'm in an open fold
set foldcolumn=1

" Automatically close folds when leaving them
set foldclose=all

" Keep the cursor 10 lines from the top/bottom of the screen
set scrolloff=10

" Automatically hit enter for me
set textwidth=80

" filetype detection for glsl
au BufRead,BufNewFile *.glslv setfiletype glsl
au BufRead,BufNewFile *.glslf setfiletype glsl
" filetype detection for arm assembly files to enable syntax highlighting
au BufNewFile,BufRead *_armv8.s,*_armv8.S set filetype=arm
" filetype detection for verilog
au BufNewFile,BufRead *.v set filetype=verilog

" Required for operations modifying multiple buffers like rename.
set hidden

" Highlight the line your cursor is on
set cursorline

" Prevent the window from resizing due to the gitgutter being added
set signcolumn=yes

" use normal regex when searching in normal/visual mode
nnoremap / /\v
" search for highlighted text when entering search from visual mode
vnoremap / y/\V<c-r>=escape(@",'/\')<cr><cr>

" ignore casing when searching w/ all lower-case letters
set ignorecase
set smartcase

" showmode hides the echodoc function signatures,
" and airline already shows the mode
set noshowmode

" persist undo history between sessions
set undofile
set undodir=~/.local/share/nvim/undo/

" List all open buffers at the top of the screen
let g:airline#extensions#tabline#enabled = 1

" just display a colored line for the git diff
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_modified_removed = '│_'

" default max number of signs is 500. causes problems with large files
let g:gitgutter_max_signs = 1000

" Prefer vimtex to latex-box
let g:tex_flavor='xetex'

" Trigger completion with <Tab>
inoremap <silent><expr> <tab>
  \ pumvisible() ? "\<c-n>" :
  \ <sid>check_back_space() ? "\<tab>" :
  \ completion#trigger_completion()
inoremap <silent><expr> <s-tab>
  \ pumvisible() ? "\<c-p>" :
  \ <sid>check_back_space() ? "\<s-tab>" :
  \ completion#trigger_completion()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" highlight yanked text
au TextYankPost * lua vim.highlight.on_yank {on_visual = false, timeout = 200}

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{prefix = '', highlight = "NonText"}
" set up the lsp settings for each language upon entering a buffer
:lua << EOF
    local lspconfig = require('lspconfig')
    -- local lsp_status = require('lsp-status')
    -- -- lsp_status.register_progress()
    local buf_set_keymap = vim.api.nvim_buf_set_keymap
    -- -- -- local capabilities = lsp_status.capabilities
    -- -- -- capabilities.textDocument.completion.completionItem.snippetSupport = false
    local capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = false
                }
            }
        }
    }

    local on_attach = function(client, bufnr)
        require('completion').on_attach(client)
        -- require('lsp_extensions').inlay_hints{prefix = '', highlight = 'NonText'}
        -- lsp_status.on_attach(client, bufnr)

        local opts = { noremap=true, silent=true }
        -- there are several goto def/impl/decl actions. this first one is my favorite
        buf_set_keymap(bufnr, 'n', 'gd',             '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        buf_set_keymap(bufnr, 'n', '<c-]>',          '<cmd>lua vim.lsp.buf.definition()<cr>', opts) -- the traditional mapping

        buf_set_keymap(bufnr, 'n', 'K',              '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        buf_set_keymap(bufnr, 'n', 'gD',             '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        buf_set_keymap(bufnr, 'n', '<c-k>',          '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        buf_set_keymap(bufnr, 'n', '1gD',            '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        buf_set_keymap(bufnr, 'n', 'gr',             '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        buf_set_keymap(bufnr, 'n', 'g0',             '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
        buf_set_keymap(bufnr, 'n', 'gW',             '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
        buf_set_keymap(bufnr, 'n', '<localleader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        buf_set_keymap(bufnr, 'n', '<localleader>d', '<cmd>lua vim.lsp.util.show_line_diagnostics()<cr>', opts)

        -- configuration for diagnostics
        buf_set_keymap(bufnr, 'n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
        buf_set_keymap(bufnr, 'n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)

        -- TODO: add a mapping for goto implementation
        -- buf_set_keymap(bufnr, 'n', 'gd',          '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    end

    local servers = {
        ["rust_analyzer"] = {},
        ["pyls"] = {},
        ["clangd"] = {},
        ["gopls"] = {},
        ["tsserver"] = {},
        ["texlab"] = {},
        ["bashls"] = {},
        ["html"] = {},
        ["cssls"] = {}
    }
    for lsp, setup_config in pairs(servers) do
        -- these settings are shared among all the servers
        setup_config.on_attach = on_attach
        setup_config.capabilities = capabilities
        lspconfig[lsp].setup(setup_config)
    end
EOF

set completeopt=noinsert,menuone,noselect
set shortmess+=c " avoid extra messages during completion
set pumheight=20 " display 20 items at most

" Goto previous/next diagnostic warning/error
" nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
" nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

augroup defx_configuration
    autocmd!
    autocmd FileType defx call s:defx_my_settings()
    autocmd BufLeave,BufWinLeave  \[defx\]* call defx#call_action('add_session')
augroup END

function! s:defx_my_settings() abort
    " I like line numbers, and defx disables them by default
    set number relativenumber

    " Define mappings
    nnoremap <silent><buffer><expr> <cr>
    \ defx#is_directory() ?
    \ defx#do_action('open_tree', ['toggle']) :
    \ defx#do_action('open')
    nnoremap <silent><buffer><expr> o
    \ defx#do_action('open')
    nnoremap <silent><buffer><expr> c
    \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
    \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
    \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> P
    \ defx#do_action('preview')
    nnoremap <silent><buffer><expr> D
    \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> i
    \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> I
    \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
    \ defx#do_action('toggle_columns',
    \                'mark:indent:icon:filename:type')
    nnoremap <silent><buffer><expr> S
    \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d
    \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
    \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
    \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
    \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy
    \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
    \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
    \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> u
    \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
    \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> s
    \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
    \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
    \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
    \ line('.') == 1 ? 'G' : 'k'
    " nnoremap <silent><buffer><expr> cd
    " \ defx#do_action('change_vim_cwd')
endfunction

" show function signatures in the command line
let g:echodoc#enable_at_startup = 1

" Enable and select color schemes
syntax on
colorscheme onedark
let g:airline_theme = 'onedark'
let g:airline_section_z = '%l/%L :%c'

" create a homerow shortcut for escape
inoremap <silent> <c-space> <esc>
vnoremap <silent> <c-space> <esc>
nnoremap <silent> <c-space> <esc>
snoremap <silent> <c-space> <esc>
tnoremap <silent> <c-space> <c-\><c-n>
" easier window navigation
vmap <silent> <c-l> <c-space><c-w>l
imap <silent> <c-l> <c-space><c-w>l
nmap <silent> <c-l> <c-space><c-w>l
smap <silent> <c-l> <c-space><c-w>l
tmap <silent> <c-l> <c-space><c-w>l
vmap <silent> <c-h> <c-space><c-w>h
imap <silent> <c-h> <c-space><c-w>h
nmap <silent> <c-h> <c-space><c-w>h
smap <silent> <c-h> <c-space><c-w>h
tmap <silent> <c-h> <c-space><c-w>h
vmap <silent> <c-j> <c-space><c-w>j
imap <silent> <c-j> <c-space><c-w>j
nmap <silent> <c-j> <c-space><c-w>j
smap <silent> <c-j> <c-space><c-w>j
tmap <silent> <c-j> <c-space><c-w>j
vmap <silent> <c-k> <c-space><c-w>k
imap <silent> <c-k> <c-space><c-w>k
nmap <silent> <c-k> <c-space><c-w>k
smap <silent> <c-k> <c-space><c-w>k
tmap <silent> <c-k> <c-space><c-w>k

" Specialized mappings just for me :)
let mapleader = ' '
let maplocalleader = ' '
" quickly switch back to previous buffer
nnoremap <leader><space> <cmd>b#<cr>
" easier way to clear search highlighting
nnoremap <leader>n <cmd>noh<cr>
" delete a buffer without deleting the window
nnoremap <leader>q <cmd>Bdelete<cr>
" Open the file explorer in the current window
nnoremap <leader>t <cmd>Defx -new -show-ignored-files -columns=mark:indent:icon:filename:type:size:time -session-file=.defx-session<cr>
" Quickly splitting windows
nnoremap <leader>v <C-w>v
" Searching with fzf
nnoremap <leader>f <cmd>Files<cr>
" nnoremap <leader>f <cmd>lua require'telescope.builtin'.find_files{}<cr>
nnoremap <leader>b <cmd>Buffers<cr>
nnoremap <leader>g <cmd>Rg<cr>
nnoremap <leader>c <cmd>Commands<cr>
nnoremap <leader>h <cmd>Helptags<cr>
nnoremap <leader>m <cmd>Marks<cr>
nnoremap <leader>j <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<cr>
nnoremap <leader>J <cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<cr>
" Session management
nnoremap <leader>ss <cmd>Obsess<cr>
nnoremap <leader>sd <cmd>Obsess!<cr>
" Quick, section-based folding
nnoremap <leader>z zfa{
