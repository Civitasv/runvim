if has("unix")
  source ~/.config/nvim/viml/plugins.vim
  source ~/.config/nvim/viml/basics.vim
  source ~/.config/nvim/viml/gui.vim
  source ~/.config/nvim/viml/theme.vim
  source ~/.config/nvim/viml/autoload.vim
  source ~/.config/nvim/viml/coc.vim
  source ~/.config/nvim/viml/telescope.vim
  source ~/.config/nvim/viml/terminal.vim
endif

if has("win32")
  source ~/AppData/Local/nvim/viml/plugins.vim
  source ~/AppData/Local/nvim/viml/basics.vim
  source ~/AppData/Local/nvim/viml/gui.vim
  source ~/AppData/Local/nvim/viml/theme.vim
  source ~/AppData/Local/nvim/viml/autoload.vim
  source ~/AppData/Local/nvim/viml/coc.vim
  source ~/AppData/Local/nvim/viml/telescope.vim
  source ~/AppData/Local/nvim/viml/terminal.vim
endif

"""""" Syntax
filetype plugin indent on
syntax on

"""""" NerdTree
let NERDTreeShowHidden=1
map <silent> <C-r> :NERDTreeFind<cr>
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

"""""" Vim Markdown
" Disable math tex conceal feature
let g:tex_conceal = ''
let g:vim_markdown_math = 1

nmap <silent> <leader>p <Plug>MarkdownPreview
nmap <silent> <leader>m <Plug>MarkdownPreviewStop

let g:mkdp_auto_close = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']

"""""" better whiteleader
let g:better_whiteleader_enabled=1
let g:strip_whiteleader_on_save=1
let g:strip_whiteleader_confirm=0

