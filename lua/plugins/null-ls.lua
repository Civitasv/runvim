return {
  dir = "~/.local/share/nvim/personal/null-ls.nvim", -- for formatters and linters
  config = function()
    -- Null ls is used to configure the methods of `format, diagnostics, completion, code_actions`
    -- which isn't supply by the lsp server.
    local null_ls = require("null-ls")

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#completion
    -- local completion = null_ls.builtins.completion
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
    --[[ local code_actions = null_ls.builtins.code_actions ]]

    null_ls.setup({
      debug = false,
      should_attach = function(bufnr)
        -- Disable null-ls for files larger than 100K in size.
        if vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 100000 then
          print("(null-ls) DISABLED, file too large")
          return false
        else
          return true
        end
      end,
      sources = {
        formatting.prettier,
        formatting.black.with({ extra_args = { "--fast" } }),
        diagnostics.flake8,
        diagnostics.jsonlint,
        formatting.jq,
        --[[ code_actions.gitsigns, ]]
        formatting.latexindent,
        diagnostics.chktex
      },
      on_attach = require("plugins.lsp.handlers").on_attach
    })
  end
}
