local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_ then
  return
end

local lsp_servers = require("user.utils.lsp-servers")

mason.setup()

mason_lspconfig.setup({
  ensure_installed = lsp_servers.all_servers, -- will be installed by mason
  automatic_installation = false
})
