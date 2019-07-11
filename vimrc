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
    Plug 'vimwiki/vimwiki'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-repeat'
    Plug 'mhinz/vim-startify'
    Plug 'simnalamburt/vim-mundo'
    Plug 'ekalinin/Dockerfile.vim'
    Plug 'tpope/vim-rails'
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
    Plug 'itchyny/lightline.vim'
    Plug 'tpope/vim-unimpaired'
    Plug 'vimlab/split-term.vim'
    Plug 'mg979/vim-visual-multi'
    Plug 'keith/swift.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'janko/vim-test'

    " Themes
    " Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
    " Plug 'dracula/vim', { 'as': 'dracula' }
    " Plug 'NLKNguyen/papercolor-theme'
    " Plug 'ayu-theme/ayu-vim'
    " Plug 'lifepillar/vim-solarized8'
    " Plug 'morhetz/gruvbox'
    Plug 'rakr/vim-one'

    if has('unix')
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
    elseif has('win32') && ( has('python') || has('python2') || has('python3') )
        Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
    elseif has('win32')
        Plug 'ctrlpvim/ctrlp.vim'
        if executable('rg')
            set grepprg=rg\ --color=never
            let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
            let g:ctrlp_use_caching = 0
        endif
    endif

    Plug 'w0rp/ale'

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
let g:one_allow_italics = 1
colorscheme one

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number relativenumber
set infercase
set splitbelow
set splitright
set noerrorbells
let g:vebugger_leader=','
let mapleader = "\<space>"
let g:startify_change_to_vcs_root=1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'python': ['autopep8'],
\   'java': [''],
\}
let g:ale_linters = {
\   'java': [''],
\   'python': ['mypy'],
\}

"-----mappings-----"
if has('unix')
    nnoremap <leader>o :FZF<CR>
    nnoremap <leader>f :Rg<CR>
endif
nnoremap <leader>bg :ToggleBG<CR>
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> \- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <leader>ev :silent e ~/.vim/vimrc<CR>
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pc :PlugClean<CR>
nnoremap <leader>rp :w<CR>:!python3 %<CR>
nnoremap <leader>pt :!python3 test_%<CR>
nnoremap <leader>bn :bn<CR>     " Move to the next buffer
nnoremap <leader>bp :bp<CR>     " Move to the previous buffer
nnoremap <silent> <esc><esc> :nohlsearch<CR><esc>
vnoremap <leader>q :norm @q<CR>
nnoremap gt :!ctags -R --exclude=.git --exclude=node_modules --exclude=out --exclude=build .<CR>
nnoremap gb :ls<CR>:b<Space>
nnoremap gh :MundoToggle<CR>
nnoremap <leader>af :ALEFix<CR>
nnoremap Y y$
nnoremap gs :mksession! ./.session.vim<CR>
nnoremap gl :source ./.session.vim<CR>
nmap <silent> <M-f> :TestFile<CR>
nmap <silent> <M-s> :TestSuite<CR>

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
        autocmd BufWritePost vimrc execute "call LightlineReload()"
    else
        autocmd BufWritePost vimrc execute "source " . s:editor_root . "/vimrc"
        autocmd BufWritePost vimrc execute "call LightlineReload()"
        if has('win32') && has('gui_running')
            autocmd BufWritePost vimrc simalt ~x
        endif
    endif
augroup END

augroup RefreshVimOnChange
    autocmd!
    au FocusGained,BufEnter * :checktime
augroup END

augroup TrimTrailingWhitespace
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

if has("gui_running")
    colorscheme one
    autocmd GUIEnter * set vb t_vb=
endif

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

if has('unix') && has('gui_running')
    set macligatures
    set lines=999 columns=9999
    set guifont=Fira\ Code:h12
    set guioptions=ca
endif

if has('win32') && has('gui_running')
    set renderoptions=type:directx
    set encoding=utf-8
    autocmd GUIEnter * simalt ~x
    set guifont=Fira\ Code:h12
    set guioptions=ca
endif

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" " Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


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

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
    set background=light
endif
