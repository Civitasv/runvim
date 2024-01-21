return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      local lsp = require("utils.lsp")
      -- for haskell
      vim.g.haskell_tools = {
        tools = {
        },
        hls = {
          on_attach = lsp.on_attach,
        },
        dap = {
        },
      }
    end
  }
}
