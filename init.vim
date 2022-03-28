if has("unix")
  source ~/.config/nvim/plugins.vim
  source ~/.config/nvim/basics.vim
  source ~/.config/nvim/gui.vim
  source ~/.config/nvim/theme.vim
  source ~/.config/nvim/autoload.vim
  source ~/.config/nvim/coc.vim
  source ~/.config/nvim/terminal.vim
endif

if has("win32")
  source ~/AppData/Local/nvim/plugins.vim
  source ~/AppData/Local/nvim/basics.vim
  source ~/AppData/Local/nvim/gui.vim
  source ~/AppData/Local/nvim/theme.vim
  source ~/AppData/Local/nvim/autoload.vim
  source ~/AppData/Local/nvim/coc.vim
  source ~/AppData/Local/nvim/terminal.vim
endif

if !exists('g:vscode')
  """""" Syntax
  filetype plugin indent on
  syntax on

  """""" NerdTree
  let NERDTreeShowHidden=1
  map <silent> <leader>r :NERDTreeFind<cr>
  nnoremap <silent> <Space>n :NERDTreeToggle<CR>

  """""" fzf
  if has("unix")
    nnoremap <silent> <C-s> :BLines<CR>
    nnoremap <silent> <leader>b :Buffers<CR>
    nnoremap <silent> <C-f> :Files<CR>
    nnoremap <silent> <leader>g :Commits<CR>
    nnoremap <silent> <leader>' :Marks<CR>
    nnoremap <silent> <leader>y :History<CR>
  endif

  """""" ctrlp
  if has("win32")
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
        \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
        \}

    let g:ctrlp_map = '<leader>p'
    nnoremap <silent> <C-s> :CtrlPLine<CR>
    nnoremap <silent> <leader>b :CtrlPBuffer<CR>
    nnoremap <silent> <C-f> :CtrlPCurFile<CR>
    nnoremap <silent> <leader>y :CtrlPMRU<CR>
    nnoremap <silent> <leader>u :CtrlPUndo<CR>
  endif

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
endif

"""""" better whiteleader
let g:better_whiteleader_enabled=1
let g:strip_whiteleader_on_save=1
let g:strip_whiteleader_confirm=0
