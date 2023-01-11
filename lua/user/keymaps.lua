local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

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
keymap({ "n", "t" }, "<A-k>", function() require "dap".step_out() end, opts)
keymap({ "n", "t" }, "<A-l>", function() require "dap".step_into() end, opts)
keymap({ "n", "t" }, "<A-j>", function() require "dap".step_over() end, opts)
keymap({ "n", "t" }, "<A-h>", function() require "dap".continue() end, opts)
keymap("n", "<F5>", function() require "dap".toggle_breakpoint() end, opts)

-- Redo
keymap("n", "U", "<C-r>", opts)

-- Move down and up only one visual line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

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
keymap("n", "<Tab>", ":bn<CR>", opts)
keymap("n", "<S-Tab>", ":bp<CR>", opts)

-- Move text up and down
keymap("n", "<A-Down>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-Up>", "<Esc>:m .-2<CR>==", opts)

-- Split windows
keymap("n", "vs", ":vs<CR>", opts)
keymap("n", "sp", ":sp<CR>", opts)

-- Better marks
keymap("n", "'", "`", opts)

-- Repeat and macro
keymap("n", "`", "@a", opts)

-- Find text in file
keymap("n", "<C-s>", "<cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({}))<CR>", opts)

-- Copy and paste
keymap("n", "<C-y>", "<esc>:%y+<CR>", opts);

---------------------------------- Insert Mode --------------------------
-- Debug
keymap("i", "<F5>", function() require "dap".toggle_breakpoint() end, opts)

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
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)

---------------------------------- Visual Block Mode ------------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

---------------------------------- Terminal Mode ---------------------------
-- <C-\>: toggle terminal window
keymap("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
keymap("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
keymap("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
keymap("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
