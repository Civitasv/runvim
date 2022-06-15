local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup()

vim.api.nvim_set_keymap('n', 'f', "<cmd>HopChar1CurrentLineAC<CR>", {})
vim.api.nvim_set_keymap('n', 'F', "<cmd>HopChar1CurrentLineBC<CR>", {})
vim.api.nvim_set_keymap('n', 't', "<cmd>HopChar1CurrentLineAC<CR>", {})
vim.api.nvim_set_keymap('n', 'T', "<cmd>HopChar1CurrentLineBC<CR>", {})
vim.api.nvim_set_keymap("n", "s", "<cmd>HopChar2AC<CR>", {})
vim.api.nvim_set_keymap("n", "S", "<cmd>HopChar2BC<CR>", {})

