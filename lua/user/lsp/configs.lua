local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

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
}

lsp_installer.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

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
  "rust_analyzer",
  "jedi_language_server",
  "vuels",
}) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
