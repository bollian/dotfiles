" Tab configuration
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Show whitespace
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

" Line number gutter configuration
set number relativenumber

" Keep the cursor 10 lines from the top/bottom of the screen
set scrolloff=10

" Everything below here is plugin-specific
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'enricobacis/vim-airline-clock'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ctrlpvim/ctrlp.vim'

Plug 'rust-lang/rust.vim'

Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'

Plug 'ryanoasis/vim-devicons'
call plug#end()

" List all the buffers in a window
let g:airline#extensions#tabline#enabled = 1

" Enable pretty icons
let g:airline_powerline_fonts = 1

" automatically display the file browser
autocmd vimenter * NERDTree

" enable autocompletion
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" disable syntastic for rust files - lean on deoplete instead
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["rust"] }

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['python3', '-m', 'pyls'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd']
    \ }

" rustfmt on save
let g:rustfmt_autosave = 1

" Enable and select color schemes
syntax on
colorscheme onedark
let g:airline_theme='onedark'

" Enable Ubuntu Mono font w/ extra icons
set guifont=UbuntuMono\ Nerd\ Font\ Mono

" Specialized mappings just for me :)
let mapleader = ','
" use normal regex when searching in normal/visual mode
nnoremap / /\v
vnoremap / /\v
" ignore casing when searching w/ all lower-case letters
set ignorecase
set smartcase
" easier way to clear search highlighting
nnoremap <leader><space> :noh<cr>
