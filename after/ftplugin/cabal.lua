local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()

ht.lsp.start()

-- haskell-language-server relies heavily on codeLenses,
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, { noremap = true, silent = true, buffer = bufnr, desc = "Hoggle search" })
-- Evaluate all code snippets
vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, { noremap = true, silent = true, buffer = bufnr, desc = "Evaluate code block" })
-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<leader>rr", ht.repl.toggle, { noremap = true, silent = true, buffer = bufnr, desc = "Toggle a GHCi repl" })
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>rf", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, { noremap = true, silent = true, buffer = bufnr, desc = "Toggle a GHCi repl for the current buffer" })
vim.keymap.set("n", "<leader>rq", ht.repl.quit, { noremap = true, silent = true, buffer = bufnr, desc = "Quit the repl" })
