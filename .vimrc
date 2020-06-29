" enable dracula theme
packadd! dracula
syntax enable

" https://github.com/dracula/vim/issues/81
let g:dracula_italic = 0
colorscheme dracula

set background=dark

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

"" short cuts
let mapleader = "\<Space>"
nnoremap <leader><leader> <c-^>


" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go setlocal ts=2 sts=2 sw=2 expandtab

" vim-go shortcuts
nnoremap <leader>b :GoBuild<CR>
nnoremap <leader>r :GoRun<CR>

" open nerdtree on start
" au VimEnter *  NERDTree

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
