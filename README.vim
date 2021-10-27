" Set Python interpreter
let g:python3_host_prog = '/usr/bin/python'

call plug#begin('~/.config/nvim/plugged')
Plug 'kien/ctrlp.vim'     " 文件查找
Plug 'morhetz/gruvbox'		" 颜色主题
Plug 'scrooloose/nerdtree' " 文件树
Plug 'sheerun/vim-polyglot'     " 语法高亮插件
Plug 'jiangmiao/auto-pairs'   " 自动括号
Plug 'Yggdroot/indentLine'      " 缩进线
Plug 'ntpeters/vim-better-whitespace'  " 清除行尾无效空格
Plug 'editorconfig/editorconfig-vim'     " 支持editorconfig
Plug 'tpope/vim-surround'       " 快速替换tag或引号
Plug 'vim-airline/vim-airline'  " vim airline
Plug 'vim-airline/vim-airline-themes' " vim airline themes
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " 扩展插件管理器
call plug#end()

let g:gruvbox_italic=1
autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
autocmd InsertLeave * :silent !fcitx5-remote -c " 退出插入模式时禁用输入法
autocmd BufCreate *  :silent !fcitx5-remote -c " 创建 Buf 时禁用输入法
autocmd BufEnter *  :silent !fcitx5-remote -c " 进入 Buf 时禁用输入法
autocmd BufLeave *  :silent !fcitx5-remote -c " 离开 Buf 时禁用输入法


" =================
" 通用配置
" =================
autocmd! bufwritepost $MYVIMRC source %   " 更改配置文件后 自动加载
set runtimepath^=~/.config/nvim runtimepath+=~/.config/nvim/after
let &packpath=&runtimepath
set mouse-=a                 " 禁用鼠标
set termencoding=utf-8
set conceallevel=0
set clipboard+=unnamedplus
set encoding=utf-8           " 设置新文件的编码为 UTF-8
set autoread                 " 文件更新后自动重载
set number                   " 显示行号
set cursorline               " 高亮当前行
set ruler                    " 显示当前行号及列号
set ignorecase               " 搜索时忽略大小写
set smartcase                " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项。只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用。
set nobackup                 " 不自动备份
set nowritebackup
set noswapfile               " 不生成.swap文件
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" indentline
let g:indentLine_setConceal = 0

" deoplete
let g:deoplete#enable_at_startup = 1


" Code action on <leader>a
vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a <Plug>(coc-codeaction-selected)<CR>

" Format action on <leader>f
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Goto definition
nmap <silent> gd <Plug>(coc-definition)
" Open definition in a split window
nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L

" Open nerdtree or not
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " Show hidden files in NerdTree buffer.

" toggle between windows
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

autocmd vimenter * call SplitWindow()
fun SplitWindow()
  split
  resize +8
  wincmd j
  terminal
  startinsert
endfun
