"""""" terminal
if has("win64")
  set shell=powershell
  set shellcmdflag=-c
endif

if has("unix")
  set shell=zsh
endif

nnoremap <nowait> <leader>t :sp<CR> :term<CR> :resize 10N<CR> i
tnoremap <silent> <Esc> <C-\><C-n>
