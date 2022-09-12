local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local lsp_servers = require("user.utils.lsp-servers")

local on_attach = require("user.lsp.handlers").on_attach
local capabilities = require("user.lsp.handlers").capabilities

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = require("user.lsp.settings.sumneko_lua").settings,
})

for _, server in ipairs(lsp_servers.regular_servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
