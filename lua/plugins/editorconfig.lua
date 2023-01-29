return {
  "editorconfig/editorconfig-vim", -- editor config
  config = function()
    vim.cmd([[
      let g:EditorConfig_exclude_patterns = ['fugitive://.*']
    ]])
  end
}

