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

" Editing functionality
Plug 'moll/vim-bbye'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-rooter'

" Language IDE support
Plug 'editorconfig/editorconfig-vim'
Plug 'lervag/vimtex'
Plug 'arm9/arm-syntax-vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp' " required by ncm2, blech
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

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

" Keep the cursor 10 lines from the top/bottom of the screen
set scrolloff=10

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

" List all open buffers at the top of the screen
let g:airline#extensions#tabline#enabled = 1

" netrw configuration
let g:netrw_liststyle = 3 " use tree view by default
let g:netrw_banner = 0    " turn off the help banner
let g:netrw_winsize = 25  " default window size
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro' " add line numbers to netrw

" tab-triggered completion in insert mode
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

let g:LanguageClient_waitOutputTimeout = 60
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'python': ['python3', '-m', 'pyls'],
    \ 'rust': ['~/.cargo/bin/rls'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'cs': [expand('~/bin/omnisharp/logged-runner.sh'), '--languageserver']
    \ }

" Prefer vimtex to latex-box
let g:polyglot_disabled = ['latex']

" filetype detection for arm assembly files to enable syntax highlighting
au BufNewFile,BufRead *_armv8.s,*_armv8.S set filetype=arm

" store language server logs
let g:LanguageClient_loggingFile = expand('~/.local/share/nvim/language-client.log')

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let g:ncm2#popup_limit = 20 " display 20 items at most

" show function signatures in the command line
let g:echodoc#enable_at_startup = 1

" Use stdio async omnisharp server
let g:OmniSharp_server_stdio = 1
" Manual installation location
let g:OmniSharp_server_path = expand('~/bin/omnisharp/run')

" Enable and select color schemes
syntax on
colorscheme onedark
let g:airline_theme='onedark'

" create a homerow shortcut for escape
inoremap <silent> <c-j> <esc>
vnoremap <silent> <c-j> <esc>
nnoremap <silent> <c-j> <esc>
snoremap <silent> <c-j> <esc>
tnoremap <silent> <c-j> <c-\><c-n>
" easier horizontal window navigation
vmap <silent> <c-l> <c-j><c-w>l
imap <silent> <c-l> <c-j><c-w>l
nmap <silent> <c-l> <c-j><c-w>l
vmap <silent> <c-h> <c-j><c-w>h
imap <silent> <c-h> <c-j><c-w>h
nmap <silent> <c-h> <c-j><c-w>h

" Specialized mappings just for me :)
let mapleader = ' '
" quickly switch back to previous buffer
nnoremap <leader><space> :b#<cr>
" easier way to clear search highlighting
nnoremap <leader>n :noh<cr>
" delete a buffer without deleting the window
nnoremap <leader>q :Bdelete<cr>
" Open the file explorer in the current window
nnoremap <leader>t :Explore<cr>
" Quickly splitting windows
nnoremap <leader>v <C-w>v
" Searching with fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>g :Rg<cr>
nnoremap <leader>c :Commands<cr>
nnoremap <leader>h :Helptags<cr>
" Session management
nnoremap <leader>ss :Obsess<cr>
nnoremap <leader>sd :Obsess!<cr>
" Quick and easy scratchpad
nnoremap <leader>so :Scratch<cr>
" Quick, section-based folding
nnoremap <leader>z zfi{
" LanguageClient integration
nnoremap <silent> K :call LanguageClient_textDocument_hover()<cr>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> <leader>r :call LanguageClient_textDocument_rename()<cr>
nnoremap <silent> <leader>u :call LanguageClient_textDocument_references()<cr>
" Tabularize shortcuts
nnoremap <silent> <leader>a= :Tabularize /=<cr>
vnoremap <silent> <leader>a= :Tabularize /=<cr>
nnoremap <silent> <leader>a: :Tabularize /:\zs<cr>
vnoremap <silent> <leader>a: :Tabularize /:\zs<cr>
