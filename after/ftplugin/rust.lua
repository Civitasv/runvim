vim.keymap.set("n", "<leader>rr", "<cmd>lua require('rust-tools').runnables.runnables()<CR>", { desc = "Rust: Show runnables", buffer = true })
vim.keymap.set("n", "<leader>roc", "<cmd>lua require'rust-tools'.open_cargo_toml.open_cargo_toml()<CR>", { desc = "Rust: Open cargo toml config", buffer = true })
vim.keymap.set("n", "<leader>rp", "<cmd>lua require'rust-tools'.parent_module.parent_module()<CR>", { desc = "Rust: show parent module", buffer = true })
vim.keymap.set("n", "<leader>rg", "<cmd>lua require'rust-tools'.crate_graph.view_crate_graph(backend, output)<CR>", { desc = "Rust: show crate graph", buffer = true })
