local opts = { noremap = true, silent = true }
local opts_silent = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

------------------------ Normal Mode -----------------------------------------
-- Debug
keymap("n", "<F5>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<F6>", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F7>", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F8>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F9>", "<cmd>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.disconnect()<CR>", opts)

-- Redo
keymap("n", "U", "<C-r>", opts)

-- Move down and up only one visual line
keymap("n", "j", "gj", opts_silent)
keymap("n", "k", "gk", opts_silent)

-- Next/Previous search result
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Toggle visibility of nvim tree
keymap("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", opts)

-- Resize
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical :resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical :resize -2<CR>", opts)

-- Buffers navigate
keymap("n", "bj", ":bp<CR>", opts)
keymap("n", "bk", ":bn<CR>", opts)
keymap("n", "<Tab>", ":bn<CR>", opts)
keymap("n", "<S-Tab>", ":bp<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-Down>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("n", "<A-Up>", "<Esc>:m .-2<CR>==", opts)

-- Split windows
keymap("n", "vs", ":vs<CR>", opts)
keymap("n", "sp", ":sp<CR>", opts)

-- Better marks
keymap("n", "'", "`", opts)

-- Repeat and macro
keymap("n", "`", "@a", opts)

-- Find text in file
keymap("n", "<C-s>", "<cmd>Telescope live_grep theme=ivy<CR>", opts)

-- Find files
keymap(
  "n",
  "<C-f>",
  "<cmd>lua require('telescope.builtin').find_files()<CR>",
  opts
)

---------------------------------- Insert Mode --------------------------
-- Debug
keymap("i", "<F5>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("i", "<F6>", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("i", "<F7>", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("i", "<F8>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("i", "<F9>", "<cmd>lua require'dap'.step_out()<CR>", opts)
keymap("i", "<F10>", "<cmd>lua require'dap'.disconnect()<CR>", opts)

-- Rename
keymap(
  "i",
  "<F2>",
  '<cmd>lua require("renamer").rename()<CR>',
  opts
)

------------------------------------ Visual Mode ------------------------
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Repeat and macro
keymap("v", ".", ":normal .<CR>", opts)
keymap("v", "`", ":normal @a<CR>", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

---------------------------------- Visual Block Mode ------------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

---------------------------------- Terminal Mode ---------------------------
-- <C-\>: toggle terminal window
keymap("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
keymap("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
keymap("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
keymap("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
