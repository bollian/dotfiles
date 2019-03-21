" Tab configuration
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Line number gutter configuration
set number relativenumber

" Keep the cursor 10 lines from the top/bottom of the screen
set scrolloff=10

":augroup numbertoggle
":  autocmd!
":  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
":  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
":augroup END

" Everything below here is plugin-specific
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" List all the buffers in a window
let g:airline#extensions#tabline#enabled = 1

" automatically display the file browser
autocmd vimenter * NERDTree

" enable autocompletion
let g:deoplete#enable_at_startup = 1

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
