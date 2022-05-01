"""""" Autoload configuration file after change
if has("unix")
  autocmd! bufwritepost ~/.config/nvim/vscode/*.vim source $MYVIMRC
endif

if has("win32")
  autocmd! bufwritepost ~/AppData/Local/nvim/vscode/*.vim source $MYVIMRC
endif
