-- Null ls is used to configure the methods of `format, diagnostics, completion, code_actions`
-- which isn't supply by the lsp server.
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#completion
-- local completion = null_ls.builtins.completion
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    diagnostics.eslint,
    formatting.eslint,
    code_actions.eslint,
    formatting.prettier,
    formatting.black.with({ extra_args = { "--fast" } }),
    diagnostics.flake8,
    diagnostics.jsonlint,
    formatting.jq,
    code_actions.gitsigns,
    formatting.latexindent,
    diagnostics.chktex
  },
  on_attach = require("user.lsp.handlers").on_attach
})
