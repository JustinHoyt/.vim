set nocompatible              " be iMproved, required
if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
else
    let s:editor_root=expand("~/.vim")
endif
" Setting up plugins
if empty(glob(s:editor_root . '/autoload/plug.vim'))
    autocmd VimEnter * echom "Downloading and installing vim-plug..."
    silent execute "!curl -fLo " . s:editor_root . "/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall
endif
call plug#begin(s:editor_root . '/plugged')
    Plug 'VundleVim/Vundle.vim'
    Plug 'tpope/vim-vinegar'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'ervandew/supertab'
    Plug 'vim-airline/vim-airline'
    Plug 'altercation/vim-colors-solarized'
    Plug 'tpope/vim-commentary'
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-repeat'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'pangloss/vim-javascript'
    Plug 'artur-shaik/vim-javacomplete2'
    Plug 'majutsushi/tagbar'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'

if version >= 800 || has('nvim')
    Plug 'w0rp/ale'
    let g:ale_fixers = {
    \   'javascript': ['eslint'],
    \   'python': ['autopep8'],
    \}
    let g:ale_linters = {
    \   'python': ['mypy'],
    \}
    let g:ale_fix_on_save = 1
endif

if version >= 800
    Plug 'maralla/completor.vim'
endif

if version < 800
    Plug 'vim-syntastic/syntastic'
    Plug 'davidhalter/jedi-vim'
endif

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup = 1
    Plug 'zchee/deoplete-jedi'
endif

call plug#end()
" Setting up plugins - end

set number
syntax on                     " syntax highlighting
set showcmd                   " show (partial) command in status line
set shiftwidth=4
set background=dark
colorscheme solarized
let mapleader = "\<space>"

"-----mappings-----"
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>rt :%retab<CR>
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>rp :!python %<CR>
nnoremap <leader>pt :!pytest<CR>
nnoremap <leader>bb :b#<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>pv :!(cd ~/.vim && git pull)<CR>
nnoremap <leader>pc :PlugClean<CR>
nnoremap <leader>in :set invnumber<CR>

cmap w!! w !sudo tee > /dev/null % " Allow saving of files as sudo when I forgot to start vim using sudo
set pastetoggle=<leader>pp
" more natural windows mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-=> <C-W><C-=>
" buffer mappings
set hidden		      " This allows buffers to be hidden if you've modified a buffer
nnoremap <leader>t :enew<cr>  " To open a new empty buffer
nnoremap <S-l> :bnext<CR>     " Move to the next buffer
nnoremap <S-h> :bprevious<CR> " Move to the previous buffer
let g:UltiSnipsJumpForwardTrigger="<leader>j"
let g:UltiSnipsJumpBackwardTrigger="<leader>k"

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
