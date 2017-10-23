set nocompatible              " be iMproved, required
so ~/.vim/plugins.vim
set number
syntax on                     " syntax highlighting
set showcmd                   " show (partial) command in status line
set shiftwidth=4
set background=dark
colorscheme solarized
let mapleader = "\<space>"

"-----mappings-----"
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ep :e ~/.vim/plugins.vim<cr>
nnoremap <leader>rt :%retab<CR>
nnoremap <leader>pi :PluginInstall<CR>
nnoremap <leader>rp :!python %<CR>
nnoremap <leader>pt :!pytest %<CR>
" more natural windows mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-=> <C-W><C-=>
" buffer mappings
set hidden 		      " This allows buffers to be hidden if you've modified a buffer
nmap <leader>t :enew<cr>      " To open a new empty buffer
nmap <leader>l :bnext<CR>     " Move to the next buffer
nmap <leader>h :bprevious<CR> " Move to the previous buffer

"-----auto-commands-----"
augroup autosourcing
    autocmd!
    autocmd BufWritePost ~/.vim/vimrc source %
augroup END

" Set location for swapfiles
set directory=$HOME/.vim/swap//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undo//

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
