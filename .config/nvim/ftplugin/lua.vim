" show existing tab with 2 spaces width
setlocal tabstop=2
" when indenting with '>', use 2 spaces width
" also sets the number of spaces to be inserted b/c softtabstop=-1
setlocal shiftwidth=2

" the above wasn't working...?
setlocal tabstop=2 softtabstop=-1 expandtab shiftwidth=2 smarttab
