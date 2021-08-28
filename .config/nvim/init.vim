let g:polyglot_disabled = ['latex']

lua require 'plugins'
lua require 'options'
lua require 'lsp'
lua require 'mappings'
lua require 'treesitter'
lua require 'statusline'
lua require 'dap-config'

"{{{ General Options
" Tab configuration
set tabstop=4 softtabstop=-1 expandtab shiftwidth=4 smarttab

set completeopt=noinsert,menuone,noselect
set shortmess+=c " avoid extra messages during completion
set pumheight=20 " display 20 items at most

" filetype detection for glsl
au BufRead,BufNewFile *.glslv setfiletype glsl
au BufRead,BufNewFile *.glslf setfiletype glsl
" filetype detection for arm assembly files to enable syntax highlighting
au BufNewFile,BufRead *_armv8.s,*_armv8.S set filetype=arm
" filetype detection for verilog
au BufNewFile,BufRead *.v set filetype=verilog

" highlight yanked text
au TextYankPost * lua vim.highlight.on_yank {on_visual = false, timeout = 200}

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{prefix = '', highlight = 'NonText'}

" Enable and select color schemes
let g:onedark_terminal_italics = 1
syntax on
" colorscheme onedark
let g:gruvbox_flat_style = "hard"
colorscheme gruvbox-flat
"}}}

"{{{ Plugin Options
" show lightbulb for codeactions
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

" highlight the buffer line
highlight link BufferCurrent       Title
highlight link BufferCurrentMod    Title
highlight link BufferCurrentSign   Title
highlight link BufferCurrentIndex  Title
highlight link BufferCurrentTarget Title
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.icons = v:false

" less aggressive highlighting
highlight clear Identifier
highlight clear Constant
highlight clear LspDiagnosticsUnderlineHint

augroup ExtraFiletypes
    autocmd!
    autocmd BufRead,BufNewFile *.jl setfiletype julia
augroup END

" just display a colored line for the git diff
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_modified_removed = '│_'

" default max number of signs is 500. causes problems with large files
let g:gitgutter_max_signs = 1000

" Prefer vimtex to latex-box
let g:tex_flavor='xetex'

" Fern config & mappings
let g:fern#disable_default_mappings = 1
let g:fern#default_hidden = 1

function! s:init_fern() abort
    " Use 'select' instead of 'edit' for default 'open' action
    " nmap <buffer> <cr> <plug>(fern-action-open-or-expand)
    nmap <buffer><expr>
          \ <plug>(fern-my-open-or-expand-or-collapse)
          \ fern#smart#leaf(
          \   "\<plug>(fern-action-open)",
          \   "\<plug>(fern-action-expand:stay)",
          \   "\<plug>(fern-action-collapse)",
          \ )

    nmap <buffer> <cr> <plug>(fern-my-open-or-expand-or-collapse)
    nmap <buffer> o    <plug>(fern-action-open)
    nmap <buffer> u    <plug>(fern-action-leave)
    nmap <buffer> i    <plug>(fern-action-new-file)
    nmap <buffer> d    <plug>(fern-action-new-dir)
    nmap <buffer> D    <plug>(fern-action-remove)
    nmap <buffer> y    <plug>(fern-action-yank)
    nmap <buffer> x    <plug>(fern-action-move)
    nmap <buffer> p    <plug>(fern-action-paste)
    nmap <buffer> r    <plug>(fern-action-rename:below)
    nmap <buffer> m    <plug>(fern-action-mark)
    nmap <buffer> cm   <plug>(fern-action-mark:clear)
    nmap <buffer> cd   <plug>(fern-action-cd)
endfunction

augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

" show function signatures in the command line
let g:echodoc#enable_at_startup = 1
"}}}

"{{{ Mappings
" use normal regex when searching in normal/visual mode
nnoremap / /\v
" search for highlighted text when entering search from visual mode
vnoremap / y/\V<c-r>=escape(@",'/\')<cr><cr>

" Trigger completion with <Tab>
inoremap <silent><expr> <tab>
  \ pumvisible() ? "\<c-n>" :
  \ <sid>check_back_space() ? "\<tab>" :
  \ compe#complete()
inoremap <silent><expr> <s-tab>
  \ pumvisible() ? "\<c-p>" : "\<s-tab>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
