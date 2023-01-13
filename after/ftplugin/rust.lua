local opts = { noremap = true, silent = true, nowait = true, buffer = true }

vim.keymap.set("n", "rr", "<cmd>lua require('rust-tools').runnables.runnables()<CR>", opts)
vim.keymap.set("n", "rk", "<cmd>lua require'rust-tools'.hover_actions.hover_actions()<CR>", opts)
vim.keymap.set("n", "rc", "<cmd>lua require'rust-tools'.open_cargo_toml.open_cargo_toml()<CR>", opts)
vim.keymap.set("n", "rp", "<cmd>lua require'rust-tools'.parent_module.parent_module()<CR>", opts)
vim.keymap.set("n", "rg", "<cmd>lua require'rust-tools'.crate_graph.view_crate_graph(backend, output)<CR>", opts)
