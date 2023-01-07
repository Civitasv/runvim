return {
  cmd = {
    "clangd",
    "--index",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--compile-commands-dir=build/Debug/"
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true
  },
  flags = { debounce_text_changes = 150 }
}

