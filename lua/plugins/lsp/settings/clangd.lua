return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--suggest-missing-includes",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--header-insertion=iwyu",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true
  },
  flags = { debounce_text_changes = 150 }
}

