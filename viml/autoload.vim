"""""" Autoload configuration file after change
if has("unix")
  autocmd! bufwritepost ~/.config/nvim/viml/*.vim source $MYVIMRC
endif

if has("win32")
  autocmd! bufwritepost ~/AppData/Local/nvim/viml/*.vim source $MYVIMRC
endif
