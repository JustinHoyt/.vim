set nocompatible              " be iMproved, required
" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set nocompatible              " be iMproved, required
    filetype off                  " required
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tpope/vim-vinegar'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'tpope/vim-sensible'
    Plugin 'tpope/vim-surround.git'
    Plugin 'ervandew/supertab'
    Plugin 'vim-airline/vim-airline'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'tpope/vim-commentary'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'tpope/vim-repeat'
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'pangloss/vim-javascript'
    Plugin 'artur-shaik/vim-javacomplete2'
    Plugin 'majutsushi/tagbar'
    Plugin 'honza/vim-snippets'
    Plugin 'SirVer/ultisnips'

    if version >= 800
        Plugin 'w0rp/ale'
	Plugin 'maralla/completor.vim'
	let g:ale_fixers = {
	\   'javascript': ['eslint'],
	\   'python': ['autopep8'],
	\}
	let g:ale_linters = {
	\   'python': ['mypy'],
	\}
	let g:ale_fix_on_save = 1
    endif

    if version < 800
        Plugin 'vim-syntastic/syntastic'
	Plugin 'davidhalter/jedi-vim'
    endif
    if iCanHazVundle == 0
        echo "Installing Vundles, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif
    call vundle#end()
    "must be last
    filetype plugin indent on " load filetype plugins/indent settings
    colorscheme solarized
    syntax on                      " enable syntax
" Setting up Vundle - the vim plugin bundler end

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
nnoremap <leader>cp :!rm -rf ~/.vim/bundle/* && git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle<CR>:PluginInstall<CR>
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
