return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft      = { "rust" },
    config  = function()
      local lsp = require("utils.lsp")
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
        },
        -- LSP configuration
        server = {
          on_attach = lsp.on_attach,
          settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
            },
          },
        },
        -- DAP configuration
        dap = {
        },
      }
    end
  }
}
