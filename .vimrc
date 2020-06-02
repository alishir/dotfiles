" enable dracula theme
packadd! dracula
syntax enable
colorscheme dracula

" enable plugins
filetype plugin indent on

" enable backspace
set backspace=indent,eol,start
" open all folds
set foldlevel=20
" set tabstop and shiftwidth
set ts=2 sts=2 sw=2
" indent newline
set cin

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go setlocal ts=2 sts=2 sw=2 expandtab



