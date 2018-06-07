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
if empty(glob(s:editor_root . '/pack/minpac/opt/minpac'))
    autocmd VimEnter * echom "Downloading and installing vim-plug..."
    if has('unix')
        silent execute "!curl -fLo " . s:editor_root . "/pack/minpac/opt/minpac --create-dirs https://github.com/k-takata/minpac.git"
    elseif has('win32')
        silent execute '!New-Item -ItemType Directory -Force -Path ' . s:editor_root . '/pack/minpack/opt'
        silent execute '!git clone https://github.com/k-takata/minpac.git ' . s:editor_root . '/pack/minpack/opt/minpac'
    endif
   autocmd! VimEnter * call minpac#update() 
endif

packadd minpac
call minpac#init()

" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add other plugins here.
call minpac#add('sheerun/vim-polyglot')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-sensible')
call minpac#add('tpope/vim-surround')
call minpac#add('itchyny/lightline.vim')
call minpac#add('vimwiki/vimwiki')
call minpac#add('tpope/vim-vinegar')
call minpac#add('tpope/vim-repeat')
call minpac#add('mhinz/vim-startify')
call minpac#add('lifepillar/vim-mucomplete')
call minpac#add('davidhalter/jedi-vim', {'type': 'opt'})
call minpac#add('artur-shaik/vim-javacomplete2', {'type': 'opt'})

if has('python') || has('python2') || has('python3')
    if has('win32')
	call minpac#add('Yggdroot/LeaderF') ", {'do': './install.bat'})
    else
	call minpac#add('Yggdroot/LeaderF', {'do': './install.sh'})
    endif
else
    call minpac#add('ctrlpvim/ctrlp.vim')
endif

if has('unix')
    call minpac#add('altercation/vim-colors-solarized')
    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('idanarye/vim-vebugger')
    call minpac#add('tpope/vim-unimpaired')
    call minpac#add('jiangmiao/auto-pairs')
    call minpac#add('rking/ag.vim')
    call minpac#add('junegunn/vim-peekaboo')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('mgee/lightline-bufferline')
endif
    
if (version >= 800 || has('nvim')) && has('unix') 
    call minpac#add('w0rp/ale')
    let g:ale_fixers = {
    \   'javascript': ['eslint'],
    \   'python': ['autopep8'],
    \   'java': [''],
    \}
    let g:ale_linters = {
    \   'python': ['mypy'],
    \}
    let g:ale_fix_on_save = 1
endif

if version < 800 && has('unix')
    call minpac#add('vim-syntastic/syntastic')
endif

syntax enable
set hlsearch
set shiftwidth=4
set background=dark
set ignorecase
set smartcase

let g:vebugger_leader=','
if has('unix')
   colorscheme solarized
endif
if has("gui_running")
   colorscheme solarized
endif
let mapleader = "\<space>"
set number relativenumber

"-----mappings-----"
nnoremap <leader>ev :silent e $MYVIMRC<CR>
nnoremap <leader>rt :%retab<CR>
nnoremap <leader>mi :call minpac#update()<CR>
nnoremap <leader>mc :call minpac#clean()<CR>
nnoremap <leader>rp :!python %<CR>
nnoremap <leader>pt :!pytest<CR>
nnoremap <leader>l :bn<CR>     " Move to the next buffer
nnoremap <leader>h :bp<CR>     " Move to the previous buffer
nnoremap <silent> <esc><esc> :nohlsearch<CR><esc>
nnoremap <leader>s :Startify<CR>
noremap <leader>q :norm @q<CR>
nnoremap gb :ls<CR>:b<Space>

" pulls vim changes from git
if has('unix')
    nnoremap <leader>pv :!(cd ~/.vim && git reset HEAD --hard && git pull)<CR>
elseif has ('win32')
    nnoremap <leader>pv :!cd ~/vimfiles; git reset HEAD --hard; git pull<CR>
endif

"" Renames word selected accross the file
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

"-----auto-commands-----"
augroup autosourcing
    autocmd!
    if has('nvim')
	autocmd BufWritePost vimrc execute "source " . s:editor_root . "/init.vim"
    else
	autocmd BufWritePost vimrc execute "source " . s:editor_root . "/vimrc"
    endif
augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
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
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>

" Set colors in windows console
if has('win32')
    if !has("gui_running")
	set term=xterm
	set t_Co=256
	let &t_AB="\e[48;5;%dm"
	let &t_AF="\e[38;5;%dm"
	inoremap <Char-0x07F> <BS>
	nnoremap <Char-0x07F> <BS>
    endif
endif

let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'

let g:lightline = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline.colorscheme = 'solarized'
set noshowmode
set showtabline=2

autocmd FileType java setlocal omnifunc=javacomplete#Complete
