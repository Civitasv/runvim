return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- show diagnostics using virtual lines
  config = function()
    local lsp_lines = require("lsp_lines")

    lsp_lines.setup()

    vim.keymap.set("n", "g?", function()
      local lines_enabled = not vim.diagnostic.config().virtual_lines
      vim.diagnostic.config(
        {
          virtual_lines = lines_enabled,
          virtual_text = not lines_enabled
        }
      )
    end, { noremap = true, silent = true })

    vim.diagnostic.config({
      virtual_text = true,
      virtual_lines = false
    })
  end
}
