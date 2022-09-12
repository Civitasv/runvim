local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_ then
  return
end

mason.setup()

local servers = {
  -- "jsonls",
  "sumneko_lua",
  "clangd",
  "cmake",
  "prosemd_lsp",
  "cmake",
  "cssls",
  "rust_analyzer",
  "jedi_language_server",
  "vuels",
  "tsserver",
  "texlab",
  "angularls",
  "eslint"
}

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = false
})
