local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local on_attach = require("user.lsp.handlers").on_attach
local capabilities = require("user.lsp.handlers").capabilities

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = require("user.lsp.settings.sumneko_lua").settings,
})

for _, server in ipairs({
  "clangd",
  "cmake",
  "prosemd_lsp",
  "cmake",
  "cssls",
  "jedi_language_server",
  "vuels",
  "tsserver",
  "texlab",
  "angularls",
  "eslint"
}) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
