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

if !exists('g:vscode')
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
  nnoremap ' `
  vnoremap . :normal .<CR>
  vnoremap ` :normal @a<CR>
  nnoremap ` @a

  nmap j gj
  nmap k gk
else
  nnoremap ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>

  nnoremap vs <cmd>call <SID>splitNew('j', '__vscode_new__')<CR>
  nnoremap sp <cmd>call <SID>splitNew('h', '__vscode_new__')<CR>

  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  nnoremap ' `
  vnoremap . :normal .<CR>
  vnoremap ` :normal @a<CR>
  nnoremap ` @a

  nmap j gj
  nmap k gk

  function! s:split(...) abort
    let direction = a:1
    let file = exists('a:2') ? a:2 : ''
    call VSCodeCall(direction ==# 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
    if !empty(file)
        call VSCodeExtensionNotify('open-file', expand(file), 'all')
    endif
  endfunction

  function! s:splitNew(...)
    let file = a:2
    call s:split(a:1, empty(file) ? '__vscode_new__' : file)
  endfunction

endif

