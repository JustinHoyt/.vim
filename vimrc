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
nnoremap <leader>pt :!pytest<CR>
nnoremap <leader>bb :b#<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>pv :!(cd ~/.vim && git pull)<CR>
cmap w!! w !sudo tee > /dev/null % " Allow saving of files as sudo when I forgot to start vim using sudo
set pastetoggle=<leader>p
" buffer mappings
set hidden		      " This allows buffers to be hidden if you've modified a buffer
nnoremap <leader>t :enew<cr>  " To open a new empty buffer
nnoremap <S-l> :bnext<CR>     " Move to the next buffer
nnoremap <S-h> :bprevious<CR> " Move to the previous buffer

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

let g:ctrlp_max_files=0 
" Ignore these directories
set wildignore+=*/build/**
set wildignore+=*/bin/**
set wildignore+=*/node_modules/**
" disable caching
let g:ctrlp_use_caching=0
let g:ctrlp_max_depth=40
