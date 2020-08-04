" First, setup plugins
call plug#begin('~/.local/share/nvim/plugged')
" UI Elements
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'duff/vim-scratch'
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
Plug 'editorconfig/editorconfig-vim'
Plug 'lervag/vimtex'
Plug 'arm9/arm-syntax-vim'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-path'
Plug 'roxma/nvim-yarp' " required by ncm2, blech
Plug 'neovim/nvim-lsp'
Plug 'liuchengxu/vista.vim'

" Aesthetic plugins
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" Only redraw when necessary (makes macros run faster)
set lazyredraw

" Tab configuration
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Show whitespace
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

" Line number gutter configuration
set number relativenumber

" Show when I'm in an open fold
set foldcolumn=1

" Automatically close folds
set foldclose=all

" Keep the cursor 10 lines from the top/bottom of the screen
set scrolloff=10

" Automatically hit enter for me
set textwidth=80

" Extra file types
au BufRead,BufNewFile *.glslv setfiletype glsl
au BufRead,BufNewFile *.glslf setfiletype glsl

" Required for operations modifying multiple buffers like rename.
set hidden

" Highlight the line your cursor is on
set cursorline

" Prevent the window from resizing due to the gitgutter being added
set signcolumn=yes

" use normal regex when searching in normal/visual mode
nnoremap / /\v
vnoremap / /\v
" ignore casing when searching w/ all lower-case letters
set ignorecase
set smartcase

" showmode hides the echodoc function signatures,
" and airline already shows the mode
set noshowmode

" persist undo history between sessions
set undofile
set undodir=~/.local/share/nvim/undo/

" allow window switching and text selection w/ a mouse
set mouse=a

" use LSP whenever possible, but keep the default as ctags
" there seems to be some stability issues when trying the finder using nvim_lsp
" on a file that doesn't have a language server
let g:vista_executive_for = {
\   'rust': 'nvim_lsp',
\   'go': 'nvim_lsp',
\   'python': 'nvim_lsp',
\   'cpp': 'nvim_lsp',
\   'c': 'nvim_lsp',
\   'typescript': 'nvim_lsp',
\   'javascript': 'nvim_lsp'
\ }
" disable the cursor blink that occurs when jumping to a symbol w/ vista
let g:vista_blink = [0, 0]
" the vista coloration is really erratic for some reason
let g:vista_keep_fzf_colors = 1
" there are already markers for the symbol types
let g:vista#renderer#enable_icon = 0
let g:vista_fzf_preview = ['right:40%']

" List all open buffers at the top of the screen
let g:airline#extensions#tabline#enabled = 1

" just display a colored line for the git diff
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_modified_removed = '│_'

" default max number of signs is 500. causes problems with large files
let g:gitgutter_max_signs = 1000

" netrw configuration
" keeping just in case I need to use netrw for some particular purpose
let g:netrw_liststyle = 3 " use tree view by default
let g:netrw_banner = 0    " turn off the help banner
let g:netrw_winsize = 25  " default window size
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro' " add line numbers to netrw

" Prefer vimtex to latex-box
let g:polyglot_disabled = ['latex']

" filetype detection for arm assembly files to enable syntax highlighting
au BufNewFile,BufRead *_armv8.s,*_armv8.S set filetype=arm

" tab-triggered completion in insert mode
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

lua require'nvim_lsp'.rust_analyzer.setup({on_init = require'ncm2'.register_lsp_source})
" lua require'nvim_lsp'.rls.setup{on_init = require'ncm2'.register_lsp_source}
lua require'nvim_lsp'.pyls.setup{on_init = require'ncm2'.register_lsp_source}
lua require'nvim_lsp'.clangd.setup{on_init = require'ncm2'.register_lsp_source}
lua require'nvim_lsp'.gopls.setup{on_init = require'ncm2'.register_lsp_source}
lua require'nvim_lsp'.tsserver.setup{on_init = require'ncm2'.register_lsp_source}

function SetLspMappings()
    nnoremap <buffer> <silent> <c-]>          <cmd>lua vim.lsp.buf.declaration()<cr>
    nnoremap <buffer> <silent> gd             <cmd>lua vim.lsp.buf.definition()<cr>
    nnoremap <buffer> <silent> K              <cmd>lua vim.lsp.buf.hover()<cr>
    nnoremap <buffer> <silent> gD             <cmd>lua vim.lsp.buf.implementation()<cr>
    " nnoremap <buffer> <silent> <c-k>          <cmd>lua vim.lsp.buf.signature_help()<cr>
    nnoremap <buffer> <silent> 1gD            <cmd>lua vim.lsp.buf.type_definition()<cr>
    nnoremap <buffer> <silent> gr             <cmd>lua vim.lsp.buf.references()<cr>
    nnoremap <buffer> <silent> <localleader>r <cmd>lua vim.lsp.buf.rename()<cr>
endfunction

augroup lsp_mappings
    autocmd!
    autocmd FileType rust,c,cpp,javascript,typescript,python,go :call SetLspMappings()
augroup END

augroup defx_configuration
    autocmd!
    autocmd FileType defx call s:defx_my_settings()
    autocmd BufLeave,BufWinLeave  \[defx\]* call defx#call_action('add_session')
augroup END
" autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    " I like line numbers, and defx disables them by default
    set number relativenumber

    " Define mappings
    nnoremap <silent><buffer><expr> <cr>
    \ defx#is_directory() ?
    \ defx#do_action('open_tree', ['toggle', 'nested']) :
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

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set pumheight=20 " display 20 items at most

" show function signatures in the command line
let g:echodoc#enable_at_startup = 1

" Use stdio async omnisharp server
let g:OmniSharp_server_stdio = 1
" Manual installation location
let g:OmniSharp_server_path = expand('~/bin/omnisharp/run')

let g:EditorConfig_max_line_indicator = "line"

" Enable and select color schemes
syntax on
colorscheme onedark
let g:airline_theme='onedark'

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
nnoremap <leader>b <cmd>Buffers<cr>
nnoremap <leader>g <cmd>Rg<cr>
nnoremap <leader>c <cmd>Commands<cr>
nnoremap <leader>h <cmd>Helptags<cr>
nnoremap <leader>m <cmd>Marks<cr>
nnoremap <leader>j <cmd>Vista finder<cr>
" Session management
nnoremap <leader>ss <cmd>Obsess<cr>
nnoremap <leader>sd <cmd>Obsess!<cr>
" Quick and easy scratchpad
nnoremap <leader>so <cmd>Scratch<cr>
" Quick, section-based folding
nnoremap <leader>z zfa{
