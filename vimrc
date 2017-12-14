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
    Plug 'altercation/vim-colors-solarized'
    Plug 'tpope/vim-vinegar'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'ervandew/supertab'
    Plug 'tpope/vim-commentary'
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-repeat'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
    Plug 'vim-airline/vim-airline'

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
    let g:deoplete#enable_debug = 1
    let g:deoplete#enable_profile = 1
    Plug 'zchee/deoplete-jedi'
    Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': 'javascript' }
    Plug 'mhartington/nvim-typescript', { 'do': 'npm install -g tern', 'for': 'typescript' }
    let g:tern_request_timeout = 1
    let g:tern_request_timeout = 6000
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]
endif

call plug#end()
" Setting up plugins - end

syntax enable
set shiftwidth=4
set background=dark
colorscheme solarized
let mapleader = "\<space>"
let hour = strftime("%H")

"-----mappings-----"
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>rt :%retab<CR>
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>rp :!python %<CR>
nnoremap <leader>pt :!pytest<CR>
nnoremap <leader>bb :b#<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>pv :!(cd ~/.vim && git reset HEAD --hard && git pull)<CR>
nnoremap <leader>pc :PlugClean<CR>
nnoremap <leader>in :set invnumber<CR>
nnoremap <leader>nh :noh<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap Y y$
:imap jk <Esc>
if has('nvim')
    " maps terminal window movements to emulate normal vim keybindings
    tnoremap <C-h> <c-\><c-n><c-w>h
    tnoremap <C-j> <c-\><c-n><c-w>j
    tnoremap <C-k> <c-\><c-n><c-w>k
    tnoremap <C-l> <c-\><c-n><c-w>l
endif

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
nnoremap <leader>l :bn<CR>     " Move to the next buffer
nnoremap <leader>h :bp<CR> " Move to the previous buffer

"-----auto-commands-----"
augroup autosourcing
    autocmd!
    if has('nvim')
	autocmd BufWritePost ~/.config/nvim/init.vim source %
    else
	autocmd BufWritePost ~/.vim/vimrc source %
    endif
augroup END

" Set location for swapfiles
set directory=$HOME/.vim/swap//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undo//

let g:ctrlp_max_files=0 
" Ignore these directories
set wildignore+=*/build/**
set wildignore+=*/bin/**
set wildignore+=*/node_modules/**
" disable caching
let g:ctrlp_use_caching=0
let g:ctrlp_max_depth=40

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" put abbreviations at the end
inoremap \dlr '${:,.2f}'.format()<esc>i
:iabbrev dlr '${:,.2f}'.format(
