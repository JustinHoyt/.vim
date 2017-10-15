set nocompatible              " be iMproved, required
so ~/.vim/plugins.vim
" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
" --------------------------------------------------------------------------------
set number
set expandtab           " enter spaces when tab is pressed
set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line
set ruler                           " show line and column number
syntax on               " syntax highlighting
set showcmd             " show (partial) command in status line
set shiftwidth=4

"colorscheme solarized
let mapleader = "\<space>"
"-----mappings-----"
nmap <leader>ev :tabedit $MYVIMRC<cr>
nmap <leader>ep :tabedit ~/.vim/plugins.vim<cr>
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>rt :%retab<CR>
let NERDTreeShowHidden=1

"-----auto-commands-----"
augroup autosourcing
    autocmd!
    autocmd BufWritePost ~/.vim/vimrc source %
augroup END

" Set location for swapfiles
set directory=$HOME/.vim/swap//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undo//

" ##################
" ### COPY-PASTE ###
" ##################

" System clipboard integration
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "_d"+p
vnoremap <leader>P "_d"+P
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>yy "+yy

" `Y` should behave like the rest of the capitals
nnoremap Y y$
" Pasting text should never update your buffers
vnoremap p "_dp
" Reselect pasted text
nnoremap <leader>v V`]


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
