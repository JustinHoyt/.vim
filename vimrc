"-----Newly Learned Vim Features-----"
" <visual> o: alternates cursor position of highlighed text
"
"
"-----Test the speed of vim on startup on unix and windows, respectively-----"
" rm -f vim.log && vim --startuptime vim.log +q && tail -n 1 vim.log | cut -f1 -d' '
" rm -force -ErrorAction Ignore vim.log; vim --startuptime vim.log +q; tail -n 1 vim.log | cut -f1 -d' '

set nocompatible              " be iMproved, required
if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
elseif has('win32')
    let s:editor_root=expand("~/vimfiles")
    set shell=powershell
    set shellcmdflag=-command
elseif has('unix')
    let s:editor_root=expand("~/.vim")
endif

" Setting up plugins
if empty(glob(s:editor_root . '/plugged'))
    autocmd VimEnter * PlugInstall
endif

call plug#begin(s:editor_root . '/plugged')
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'itchyny/lightline.vim'
    Plug 'vimwiki/vimwiki'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-repeat'
    Plug 'mhinz/vim-startify'
    Plug 'lifepillar/vim-mucomplete'
    Plug 'davidhalter/jedi-vim', { 'for': ['python'] }
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'jceb/vim-orgmode'
    Plug 'markonm/traces.vim'
    Plug 'simnalamburt/vim-mundo'
    Plug 'Quramy/tsuquyomi'
    Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
    if has('win32')
	Plug 'Shougo/vimproc.vim'
    else
	Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    endif
    if has('python') || has('python2') || has('python3')
        if has('win32')
            Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
        else
            Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
        endif
    else
        Plug 'ctrlpvim/ctrlp.vim'
    endif

if has('unix')
    Plug 'altercation/vim-colors-solarized'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'idanarye/vim-vebugger'
    Plug 'tpope/vim-unimpaired'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/vim-peekaboo'
    Plug 'mgee/lightline-bufferline'
endif


if (version >= 800 || has('nvim'))
    Plug 'w0rp/ale'
    let g:ale_fixers = {
    \   'javascript': ['eslint'],
    \   'typescript': ['tslint'],
    \   'python': ['autopep8'],
    \   'java': [''],
    \}
    let g:ale_linters = {
    \   'python': ['mypy'],
    \   'java': [''],
    \}
endif

if version < 800 && has('unix')
    Plug 'vim-syntastic/syntastic'
endif

call plug#end()
" Setting up plugins - end

syntax enable
set hlsearch
set shiftwidth=4
set background=dark
set ignorecase
set smartcase
set completeopt=longest,menuone
set incsearch
let g:gutentags_file_list_command = 'rg --files'

" let g:vebugger_leader=','
if has('unix')
    colorscheme solarized
endif
if has("gui_running")
    colorscheme solarized
endif
let mapleader = "\<space>"
let maplocalleader = ","
set number relativenumber
set infercase
set splitbelow
set splitright

"-----mappings-----"
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> \- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <leader>ev :silent e $MYVIMRC<CR>
nnoremap <leader>rt :%retab<CR>
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>rp :!python %<CR>
nnoremap <leader>pt :!pytest<CR>
nnoremap <leader>l :bn<CR>     " Move to the next buffer
nnoremap <leader>h :bp<CR>     " Move to the previous buffer
nnoremap <leader>pc :PlugClean<CR>
nnoremap <silent> <esc><esc> :nohlsearch<CR><esc>
nnoremap <leader>s :Startify<CR>
vnoremap <leader>q :norm @q<CR>
nnoremap gb :ls<CR>:b<Space>
nnoremap <leader>s :%s/\v
nnoremap gh :MundoToggle<CR>
nnoremap <leader>it :TsuImport<CR>
nnoremap <leader>af :ALEFix<CR>

if has('win32')
    nnoremap <leader>T :tab terminal<CR>Set-Theme tehrob<CR>clear<CR>
    nnoremap <leader>t :terminal<cr><C-w>:exe "resize " . (winheight(0) * 2/3)<CR>Set-Theme tehrob<CR>clear<CR>
else
    nnoremap <leader>T :tab terminal<CR>set -o vi<CR>
    nnoremap <leader>t :terminal<cr><C-w>:exe "resize " . (winheight(0) * 2/3)<CR>set -o vi<CR>
endif

" pulls vim changes from git
if has('unix')
    nnoremap <leader>pv :!(cd ~/.vim && git reset HEAD --hard && git pull)<CR>
elseif has ('win32')
    nnoremap <leader>pv :!cd ~/vimfiles; git reset HEAD --hard; git pull<CR>
endif
" Renames word selected accross the file
nnoremap <leader>rn :%s/\<<c-r><c-w>\>/
nnoremap Y y$

" mappings for vebugger
" ':help vebugger-keymaps' for more
nnoremap ,k :VBGkill<CR>
nnoremap ,s :VBGstartPDB %<CR>

" more natural windows mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-=> <C-W><C-=>

if exists(':tnoremap')
    " tnoremap <C-n> <C-\><C-n>
    tnoremap <leader><Esc> <C-\><C-n>
    tnoremap <C-J> <C-W><C-J>
    tnoremap <C-K> <C-W><C-K>
    tnoremap <C-L> <C-W><C-L>
    tnoremap <C-H> <C-W><C-H>
endif

" buffer mappings
set hidden                      " This allows buffers to be hidden if you've modified a buffer

"-----Macros-----"
let @p = 'o�#3''IPlug ''ldf/.'

"-----auto-commands-----"
augroup autosourcing
    autocmd!
    if has('nvim')
        autocmd BufWritePost vimrc execute "source " . s:editor_root . "/init.vim"
    else
        autocmd BufWritePost vimrc execute "source " . s:editor_root . "/vimrc"
        if has('win32') && has('gui_running')
            autocmd BufWritePost vimrc simalt ~x
        endif
    endif
augroup END

augroup TrimTrailingWhitespace
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup Terminal
    autocmd!
    autocmd TerminalOpen * :set nonumber norelativenumber
augroup END

" Ignore these directories
set wildignore+=*/build/**
set wildignore+=*/bin/**
set wildignore+=*/node_modules/**
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*

" put abbreviations at the end
inoremap \dlr '${:,.2f}'.format()<esc>i

" Set colors in windows console
if has('win32') && !has('gui_running') && !empty($CONEMUBUILD)
    set term=xterm
    set t_Co=256
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
endif

if has('win32') && has('gui_running')
    autocmd GUIEnter * simalt ~x
    set guifont=consolas:h13
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
endif

let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline.colorscheme = 'solarized'
set noshowmode
if has('unix')
    set showtabline=2
endif

