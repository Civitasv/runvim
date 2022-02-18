"""""" Basic Options
set background=light " apply the color set for white screens
set clipboard=unnamedplus " enables the clipboard between Neovim and other applications
set completeopt=noinsert,menuone,noselect " modifies the auto-complete menu to behave more like an IDE
set cursorline " highlights the current line in the editor
set hidden " hide unused buffers
set inccommand=split " show replacements in a split screen, before applying to the file
set mouse=a " allows the use of the mouse
set number " show line numbers
set relativenumber " show relative line numbers
set splitbelow splitright " changes split screen behavior with the command :split (split horizontally) and :vsplit (vertically). In this case, the screens will always split below the current screen and to the right.
set title " show the file title
set ttimeoutlen=0 " time in milliseconds to run commands
set wildmenu " show a more advanced menu for auto-completion suggestions
set autoread " after change file, revert it

let $LC_ALL="en_US.UTF-8"
language en_US.UTF-8
set encoding=UTF-8
set fileencodings=UTF-8

set nobackup
set nowritebackup
let mapleader=","

"""" GUI
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=Fira\ Code\ Retina:h12

"""""" Tabs size
set expandtab " transform tabs into spaces
set shiftwidth=2 " number of spaces for indentation
set tabstop=2 " number of spaces for tabs

"""""" Syntax
filetype plugin indent on
syntax on

"""""" Color Support
set t_Co=256

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

"""""" Support for true italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

"""""" Autoload configuration file after change
autocmd! bufwritepost $MYVIMRC source %

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
    " Git
    Plug 'airblade/vim-gitgutter' " show git changes in open files
    " Color Scheme
    Plug 'morhetz/gruvbox'
    Plug 'NLKNguyen/papercolor-theme'
    " Fuzzy file, buffer, mru, tag
    Plug 'ctrlpvim/ctrlp.vim'
    " Indent Line
    Plug 'Yggdroot/indentLine'
    " Clear unuseful whitespaces
    Plug 'ntpeters/vim-better-whitespace'
    " Git
    Plug 'tpope/vim-fugitive'
    " comment
    Plug 'preservim/nerdcommenter'
call plug#end()

"""""" Color Scheme
colorscheme PaperColor

"""""" Airline
let g:airline_theme='papercolor'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

"""""" NerdTree
let NERDTreeShowHidden=1

"""""" CTRLP
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>l :CtrlPLine<CR>

"""""" Vim Markdown
" Disable math tex conceal feature
let g:tex_conceal = ''
let g:vim_markdown_math = 1

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']

"""""" Conquer of Completion
set cmdheight=2 " more space for displaying messages
set updatetime=300 " make it smooth
set shortmess+=c " don't pass messages to  |ins-completion-menu|
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""" Keyboard shortcuts
" Normal mode remappings, <CR> means Enter
nnoremap <C-q> :q!<CR>
" close the open file
nnoremap <F4> :bd<CR>
" show or hide nerdtree
nnoremap <F5> :NERDTreeToggle<CR>
" opens a terminal in a lower split window
nnoremap <F6> :sp<CR>:terminal<CR>
" Tabs
" create a new tab
nnoremap <silent> <S-t> :tabnew<CR>

"""""" Automatic commands

"""""" better whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

"""""" Indent Line
let g:indentLine_setConceal=0

"""""" airline
set laststatus=2

"""""" toggle between windows
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

"""""" terminal
set shell=powershell
set shellcmdflag=-c
tnoremap <leader><ESC> <C-\><C-n>

