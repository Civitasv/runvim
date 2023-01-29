return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()

    local mason = require("mason")

    local mason_lspconfig = require("mason-lspconfig")

    local lsp_servers = require("utils.lsp-servers")

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = lsp_servers.all_servers, -- will be installed by mason
      automatic_installation = false
    })
  end
}
