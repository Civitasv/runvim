local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<leader>la",
  function()
    vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)

-- Cargo run
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd.RustLsp("runnables")
end, { silent = true, buffer = bufnr, desc = "Run" })
