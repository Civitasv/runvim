local M = {}

M.all_servers = {
  -- "jsonls",
  "lua_ls",
  "clangd",
  "prosemd_lsp",
  "cssls",
  "rust_analyzer",
  "vuels",
  "tsserver",
  "texlab",
  "angularls",
  "eslint",
}

M.regular_servers = {
  "prosemd_lsp",
  "cssls",
  "vuels",
  "tsserver",
  "texlab",
  "angularls",
  "eslint",
}

return M
