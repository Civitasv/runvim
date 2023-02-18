local M = {}

M.all_servers = {
  -- "jsonls",
  "lua_ls",
  "clangd",
  "cmake",
  "prosemd_lsp",
  "cssls",
  "rust_analyzer",
  "jedi_language_server",
  "vuels",
  "tsserver",
  "texlab",
  "angularls",
  "eslint",
  "taplo"
}

M.regular_servers = {
  "cmake",
  "prosemd_lsp",
  "cssls",
  "jedi_language_server",
  "vuels",
  "tsserver",
  "texlab",
  "angularls",
  "eslint",
  "taplo"
}

return M
