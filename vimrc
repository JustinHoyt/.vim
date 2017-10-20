set nocompatible              " be iMproved, required
so ~/.vim/plugins.vim
set number
syntax on               " syntax highlighting
set showcmd             " show (partial) command in status line
set shiftwidth=4
set background=dark
colorscheme solarized
let mapleader = "\<space>"

"-----mappings-----"
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>ep :tabedit ~/.vim/plugins.vim<cr>
nnoremap <leader>rt :%retab<CR>
nnoremap <leader>pi :PluginInstall<CR>
nnoremap <leader>rp :!python %<CR>
" more natural windows mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" multicursor mapping
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<C-c>'
nnoremap <C-c> :call multiple_cursors#quit()<CR>

"-----auto-commands-----"
augroup autosourcing
    autocmd!
    autocmd BufWritePost ~/.vim/vimrc source %
augroup END

" Set location for swapfiles
set directory=$HOME/.vim/swap//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undo//
