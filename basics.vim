"""""" Basic Options
let mapleader=" "
set relativenumber " show relative line numbers
set wrap " when line is too long, wrap it
set linebreak " a better looking after wraping lines
set clipboard=unnamedplus " enables the clipboard between Neovim and other applications
set expandtab " transform tabs into leaders
set shiftwidth=2 " number of leaders for indentation
set tabstop=2 " number of leaders for tabs
set incsearch
set hlsearch
set ignorecase
set splitbelow splitright
set scrolloff=5
set noerrorbells
set termguicolors
set noshowmode
set showtabline=2
set cursorline " highlights the current line in the editor
set mouse=a " allows the use of the mouse
set title " show the file title
set ttimeoutlen=0 " time in milliseconds to run commands
set autoread " after change file, revert it
set wildmenu " show a more advanced menu for auto-completion suggestions
set encoding=UTF-8
set fileencodings=UTF-8
set noswapfile
set nobackup
set nowritebackup
set hidden

nnoremap vs :vs<CR>
nnoremap sp :sp<CR>
nnoremap tn :tabnew<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap to :tabo<CR>

nnoremap bk :bn<CR>
nnoremap bj :bp<CR>
nnoremap bd :bd<CR>
nnoremap nh :noh<CR>
nnoremap <leader>s :%s/

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nmap j gj
nmap k gk
