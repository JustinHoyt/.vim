"-----Newly Learned Vim Features-----"
" <visual> o: alternates cursor position of highlighed text
" <C-f> inside command mode opens the command line window
" q: does the same thing but from normal mode
"
"-----Test the speed of vim on startup on unix and windows, respectively-----"
" rm -f vim.log && vim --startuptime vim.log +q && tail -n 1 vim.log | cut -f1 -d' '
" rm -force -ErrorAction Ignore vim.log; vim --startuptime vim.log +q; tail -n 1 vim.log | cut -f1 -d' '

set nocompatible              " be iMproved, required
if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
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
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-repeat'
    Plug 'mhinz/vim-startify'
    Plug 'tpope/vim-unimpaired'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'itchyny/lightline.vim'
    Plug 'honza/vim-snippets'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'w0rp/ale'
    Plug 'rakr/vim-one'
    Plug 'cormacrelf/vim-colors-github'

    if version < 800 && has('unix')
        Plug 'vim-syntastic/syntastic'
    endif

call plug#end()

syntax enable
set hlsearch
set shiftwidth=4
set ignorecase
set smartcase
set completeopt=longest,menuone
set incsearch
set termguicolors
let mapleader = " "

let g:one_allow_italics = 1
colorscheme github

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number relativenumber
set infercase
set splitbelow
set splitright
set noerrorbells
let g:startify_change_to_vcs_root=1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\}

"-----mappings-----"
if has('unix')
    nnoremap <leader>o :FZF<CR>
    nnoremap <leader>f :Rg<CR>
endif
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> \- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <leader>ev :silent e ~/.vim/vimrc<CR>
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pc :PlugClean<CR>
nnoremap <leader>rp :w<CR>:!python3 %<CR>
nnoremap <leader>tp :!python3 test_%<CR>
nnoremap <leader>rj :w<CR>:!node %<CR>
nnoremap <leader>bn :bn<CR>     " Move to the next buffer
nnoremap <leader>bp :bp<CR>     " Move to the previous buffer
nnoremap <silent> <esc><esc> :nohlsearch<CR><esc>
vnoremap <leader>q :norm @q<CR>
nnoremap gt :!ctags -R --exclude=.git --exclude=node_modules --exclude=out --exclude=build .<CR>
nnoremap gb :ls<CR>:b<Space>
nnoremap <leader>af :ALEFix<CR>
nnoremap Y y$
nnoremap gs :mksession! ./.session.vim<CR>
nnoremap gl :source ./.session.vim<CR>

if exists(':tnoremap')
    nnoremap <leader>t :20Term<CR>
    nnoremap gh :Term<CR>
    nnoremap gv :VTerm<CR>

    let g:disable_key_mappings=1
    tnoremap \\ <C-\><C-n>
    " Alt+[hjkl] to navigate through windows in insert mode
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l

    " Alt+[hjkl] to navigate through windows in normal mode
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

    " Ctrl+Arrows to navigate through windows in insert mode
    tnoremap <C-Left>  <C-\><C-n><C-w>h
    tnoremap <C-Down>  <C-\><C-n><C-w>j
    tnoremap <C-Up>    <C-\><C-n><C-w>k
    tnoremap <C-Right> <C-\><C-n><C-w>l

    " Easier time when pasting content in terminal mode with <C-v>
    tnoremap <expr> <C-v> '<C-\><C-N>pi'
endif

" pulls vim changes from git
if has('unix')
    nnoremap <leader>pv :!(cd ~/.vim && git reset HEAD --hard && git pull)<CR>
elseif has ('win32')
    nnoremap <leader>pv :!cd ~/vimfiles; git reset HEAD --hard; git pull<CR>
endif

" Renames selected word accross the file
nnoremap <leader>rn :%s/\<<c-r><c-w>\>/

" more natural windows mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-=> <C-W><C-=>

" buffer mappings
set hidden                      " This allows buffers to be hidden if you've modified a buffer

"-----Macros-----"
" Takes clipboard link of github to plugin and turns it into vim-plug syntax
let @p = 'oPlug ''''"+PF''ldf/.'

"-----auto-commands-----"
augroup autosourcing
    autocmd!
    if has('nvim')
        autocmd BufWritePost vimrc execute "source " . s:editor_root . "/init.vim"
    else
        autocmd BufWritePost vimrc execute "source " . s:editor_root . "/vimrc"
    endif
    autocmd BufWritePost vimrc execute "call LightlineReload()"
augroup END

augroup RefreshVimOnChange
    autocmd!
    au FocusGained,BufEnter * :checktime
augroup END

augroup TrimTrailingWhitespace
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
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

" Better display for messages
set cmdheight=2

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

function! LightlineReload()
    runtime autoload/lightline/colorscheme/one.vim
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

function! SetBackgroundMode(...)
    let systemColor = system("defaults read -g AppleInterfaceStyle")
    if systemColor =~ 'Dark' && &background == "light"
        set background=dark
        call LightlineReload()
    elseif systemColor =~ 'does not exist' && &background == "dark"
        set background=light
        call LightlineReload()
    endif
endfunction

if has('macunix')
    call SetBackgroundMode()
    call timer_start(1000, "SetBackgroundMode", {"repeat": -1})
    set guicursor=a:blinkon500
else
    " set background=light
endif
