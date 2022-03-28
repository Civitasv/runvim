"""""" terminal
if !exists('g:vscode') 
  if has("win64")
    set shell=powershell
    set shellcmdflag=-c
  endif

  if has("unix")
    set shell=zsh
  endif

  nnoremap <nowait> <leader>t :term<CR> i
  tnoremap <silent> <Esc> <C-\><C-n>
endif
