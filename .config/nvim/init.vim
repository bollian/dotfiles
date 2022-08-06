let g:polyglot_disabled = ['latex']

lua require 'plugins'
lua require 'options'
lua require 'lsp'
lua require 'mappings'
lua require 'treesitter'
lua require 'statusline'
lua require 'dap-config'

"{{{ General Options
" filetype detection for glsl
au BufRead,BufNewFile *.glslv setfiletype glsl
au BufRead,BufNewFile *.glslf setfiletype glsl
" filetype detection for arm assembly files to enable syntax highlighting
au BufNewFile,BufRead *_armv8.s,*_armv8.S set filetype=arm
" filetype detection for verilog
au BufNewFile,BufRead *.v set filetype=verilog

" highlight yanked text
au TextYankPost * lua vim.highlight.on_yank {on_visual = false, timeout = 200}

" Disable autocompletion in telescope window
autocmd FileType TelescopePrompt lua require'cmp'.setup.buffer {
\   completion = { autocomplete = false }
\ }

" Enable and select color schemes
syntax on
let g:gruvbox_flat_style = "hard"
colorscheme gruvbox-flat
"}}}

"{{{ Plugin Options
" show lightbulb for codeactions
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

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
"}}}

"{{{ Mappings
" use normal regex when searching in normal/visual mode
nnoremap / /\v
" search for highlighted text when entering search from visual mode
vnoremap / y/\V<c-r>=escape(@",'/\')<cr><cr>
