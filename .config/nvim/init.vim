" First, setup plugins
call plug#begin('~/.local/share/nvim/plugged')
" UI Elements
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'duff/vim-scratch'
Plug 'kshenoy/vim-signature'
Plug 'vim-airline/vim-airline'
Plug 'wesq3/vim-windowswap'

" Editing functionality
Plug 'moll/vim-bbye'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'

" Aesthetic/UI plugins
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

" List all open buffers at the top of the screen
let g:airline#extensions#tabline#enabled = 1
" Enable pretty icons
let g:airline_powerline_fonts = 1

" netrw configuration
let g:netrw_liststyle = 3 " use tree view by default
let g:netrw_banner = 0    " turn off the help banner
let g:netrw_winsize = 25  " default window size
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro' " add line numbers to netrw

" tab-triggered completion in insert mode
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['python3', '-m', 'pyls'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd']
    \ }

" Enable and select color schemes
syntax on
colorscheme onedark
let g:airline_theme='onedark'

" Highlight the line your cursor is on
set cursorline

" Prevent the window from resizing due to the gitgutter being added
set signcolumn=yes

" Use Coc to jump to definition
nnoremap <c-]> :call CocAction('jumpDefinition')<cr>

" use normal regex when searching in normal/visual mode
nnoremap / /\v
vnoremap / /\v
" ignore casing when searching w/ all lower-case letters
set ignorecase
set smartcase

" Specialized mappings just for me :)
let mapleader = ','
" easier way to clear search highlighting
nnoremap <leader><space> :noh<cr>
" delete a buffer without deleting the window
nnoremap <leader>q :Bdelete<cr>
" Open the file explorer in the current window
nnoremap <leader>t :Explore<cr>
" Quickly splitting windows
nnoremap <leader>v <C-w>v
nnoremap <leader>f :FZF<cr>
" nnoremap <leader>s :ToggleWorkspace<cr>
nnoremap <leader>ss :Obsess<cr>
nnoremap <leader>sd :Obsess!<cr>
nnoremap <leader>so :Scratch<cr>
" Quick, section-based folding
nnoremap <leader>z zfi{
