"""""" Plugin
call plug#begin()
    " Appearance
    Plug 'vim-airline/vim-airline' " pleasant air line
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons' " show icons in the interface
    " Utilities
    Plug 'sheerun/vim-polyglot' " syntax highlighting
    Plug 'jiangmiao/auto-pairs' " automatically close delimiters
    Plug 'ap/vim-css-color' " show colors directly in the code
    Plug 'preservim/nerdtree' " sidebar to project files
    " Completion / linters / formatters
    Plug 'neoclide/coc.nvim',  {'branch': 'release'} " provides auto-completion
    Plug 'plasticboy/vim-markdown' " markdown support
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }
    " Color Scheme
    Plug 'morhetz/gruvbox'
    Plug 'NLKNguyen/papercolor-theme'
    " Clear unuseful whitespaces
    Plug 'ntpeters/vim-better-whitespace'
    " Git
    Plug 'tpope/vim-fugitive'
    " Comment
    Plug 'tpope/vim-commentary'
    " vim surround
    Plug 'tpope/vim-surround'
    " fuzzy finder
    if has('win32')
        Plug 'ctrlpvim/ctrlp.vim'
    endif
    if has('unix')
        " fzf
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
    endif
call plug#end()
