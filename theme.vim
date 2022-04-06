"""""" Color Scheme
if !exists('g:vscode')
  set bg=dark
  let g:gruvbox_transparent_bg=1
  let g:gruvbox_contrast_dark="hard"

  colorscheme gruvbox

  """""" Transparent background
  hi Normal guibg=NONE ctermbg=NONE

  """""" Airline
  set laststatus=2
  let g:airline_theme='gruvbox'
  let g:airline_powerline_fonts=1
  let g:airline#extensions#tabline#enabled=1

  """""" Support for true italics
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
endif
