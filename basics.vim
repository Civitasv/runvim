let mapleader=" "
set clipboard=unnamedplus " enables the clipboard between Neovim and other applications
set incsearch
set hlsearch
set ignorecase
set termguicolors
set noswapfile
set nobackup
set nowritebackup
set encoding=UTF-8
set fileencodings=UTF-8
set autoread " after change file, revert it

"""""" Basic Options
set relativenumber " show relative line numbers
set wrap " when line is too long, wrap it
set linebreak " a better looking after wraping lines
set expandtab " transform tabs into leaders
set shiftwidth=2 " number of leaders for indentation
set tabstop=2 " number of leaders for tabs
set splitbelow splitright
set scrolloff=5
set noerrorbells
set noshowmode
set showtabline=2
set cursorline " highlights the current line in the editor
set mouse=a " allows the use of the mouse
set title " show the file title
set ttimeoutlen=0 " time in milliseconds to run commands
set wildmenu " show a more advanced menu for auto-completion suggestions
set hidden

nnoremap vs :vs<CR>
nnoremap sp :sp<CR>

nnoremap bk :bn<CR>
nnoremap bj :bp<CR>
nnoremap bd :bd<CR>
nnoremap <ESC>nh :noh<CR>
nnoremap <leader>s :%s/

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap ' `
vnoremap . :normal .<CR>
vnoremap ` :normal @a<CR>
nnoremap ` @a

nmap j gj
nmap k gk
