return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      -- for haskell
      vim.g.haskell_tools = {
        tools = {
        },
        hls = {
          on_attach = on_attach,
        },
        dap = {
        },
      }
    end
  }
}
