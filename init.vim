source ~/.config/nvim/plugins.vim
source ~/.config/nvim/basics.vim
source ~/.config/nvim/terminal.vim
source ~/.config/nvim/gui.vim
source ~/.config/nvim/theme.vim
source ~/.config/nvim/autoload.vim
source ~/.config/nvim/coc.vim

"""""" Syntax
filetype plugin indent on
syntax on

"""""" NerdTree
let NERDTreeShowHidden=1
map <silent> <leader>r :NERDTreeFind<cr>
nnoremap <silent> <Space>n :NERDTreeToggle<CR>

"""""" fzf
nnoremap <silent> <C-s> :BLines<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>g :Commits<CR>
nnoremap <silent> <leader>' :Marks<CR>
nnoremap <silent> <leader>y :History<CR>
" - down / up / left / right
let g:fzf_layout = { 'down': '30%' }

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

