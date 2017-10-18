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
    "Add your bundles here
    Plugin 'tpope/vim-vinegar'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'tpope/vim-sensible'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'tpope/vim-surround.git'
    Plugin 'tpope/vim-fugitive.git'
    " Plugin 'vim-syntastic/syntastic'
    Plugin 'w0rp/ale'
    Plugin 'davidhalter/jedi-vim'
    Plugin 'ervandew/supertab'
    Plugin 'vim-airline/vim-airline'
    Plugin 'altercation/vim-colors-solarized' 
    Plugin 'justinmk/vim-sneak'
    Plugin 'tpope/vim-commentary'
    Plugin 'sheerun/vim-polyglot'

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
