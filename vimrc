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
    Plug 'honza/vim-snippets'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'w0rp/ale'
    Plug 'rakr/vim-one'
    Plug 'tpope/vim-fugitive'
    Plug 'RRethy/vim-illuminate'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'cormacrelf/vim-colors-github'
    Plug 'itchyny/lightline.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'mg979/vim-visual-multi'
    if version < 800 && has('unix')
        Plug 'vim-syntastic/syntastic'
    endif

call plug#end()

syntax enable
set hlsearch
set shiftwidth=4
set ignorecase
set smartcase
set completeopt=menu,menuone,noselect
set incsearch
if !has('mac')
    let g:auto_color_switcher#desable = v:true
endif
let mapleader = " "

if (has("termguicolors"))
    set termguicolors
    set t_Co=256
endif

if has('nvim')
    let g:one_allow_italics = 1
    colorscheme one
endif

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
\  'javascript': ['eslint'],
\  'typescript': ['tslint'],
\}
let g:ale_linters = {
\  'cs':['syntax', 'semantic', 'issues'],
\  'python': ['pylint'],
\  'java': []
\ }

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
nnoremap gt :!ctags -R --exclude=.git --exclude=node_modules --exclude=out --exclude=build .<CR>
nnoremap gb :ls<CR>:b<Space>
nnoremap <leader>af :ALEFix<CR>
nnoremap Y y$
nnoremap gs :mksession! ./.session.vim<CR>
nnoremap gl :source ./.session.vim<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap [l :set norelativenumber nonumber<CR>:GitGutterDisable<CR>
nnoremap ]l :set relativenumber number<CR>:GitGutterEnable<CR>

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
let @p = "oPlug '*'T/;dT'"

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'gitbranch', 'filename', 'readonly', 'modified' ],
  \   ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \   ],
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \ },
\ }

function UpdateBackground()
    if system("defaults read -g AppleInterfaceStyle") == "Dark\n"
        if &bg == "light" | set bg=dark | endif
    else
        if &bg == "dark" | set bg=light | endif
    endif
    runtime autoload/lightline/colorscheme/one.vim
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

"-----auto-commands-----"
if has('nvim')
    augroup nightfall
      autocmd!
      autocmd FocusGained,BufEnter * call UpdateBackground()
    augroup END
endif

augroup autosourcing
    autocmd!
    if has('nvim')
        autocmd BufWritePost vimrc execute "source " . s:editor_root . "/init.vim"
    else
        autocmd BufWritePost vimrc execute "source " . s:editor_root . "/vimrc"
    endif
    autocmd BufWritePost vimrc execute UpdateBackground()
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

au FileType java call SetWorkspaceFolders()

function! SetWorkspaceFolders() abort
    " Only set g:WorkspaceFolders if it is not already set
    if exists("g:WorkspaceFolders") | return | endif

    if executable("findup")
        let l:ws_dir = trim(system("cd '" . expand("%:h") . "' && findup packageInfo"))
        " Bemol conveniently generates a '$WS_DIR/.bemol/ws_root_folders' file, so let's leverage it
        let l:folders_file = l:ws_dir . "/.bemol/ws_root_folders"
        if filereadable(l:folders_file)
            let l:ws_folders = readfile(l:folders_file)
            let g:WorkspaceFolders = filter(l:ws_folders, "isdirectory(v:val)")
        endif
    endif
endfunction


lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local eclipse_dir = os.getenv('HOME') .. '/.config/eclipse-jdt/'

nvim_lsp['jdtls'].setup {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. eclipse_dir .. '/lombok.jar',
    '-Xbootclasspath/a:' .. eclipse_dir .. '/lombok.jar',
    '-jar', eclipse_dir .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', eclipse_dir .. '/config_linux',
    '-data', eclipse_dir .. project_name
  },

  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  }
}
EOF

