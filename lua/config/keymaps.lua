vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

------------------------ Normal Mode -----------------------------------------
-- Redo
keymap("n", "U", "<C-r>", { silent = true, desc = "Redo" })

-- Move down and up only one visual line
keymap("n", "j", "v:count==0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count==0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Next/Previous search result
keymap("n", "n", "nzzzv", { silent = true })
keymap("n", "N", "Nzzzv", { silent = true })

-- Window navigation
keymap({ "n", "i" }, "<C-h>", "<C-w>h", { silent = true, desc = "Go to left window" })
keymap({ "n", "i" }, "<C-j>", "<C-w>j", { silent = true, desc = "Go to lower window" })
keymap({ "n", "i" }, "<C-k>", "<C-w>k", { silent = true, desc = "Go to upper window" })
keymap({ "n", "i" }, "<C-l>", "<C-w>l", { silent = true, desc = "Go to right window" })

-- Toggle visibility of nvim tree
keymap("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "toggle neovim tree" })

-- Resize
keymap("n", "<C-Up>", ":resize +2<CR>", { silent = true, desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { silent = true, desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical :resize -2<CR>", { silent = true, desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical :resize +2<CR>", { silent = true, desc = "Increase window width" })

-- Buffers navigate
keymap("n", "<Tab>", ":bn<CR>", { silent = true, desc = "next tab" })
keymap("n", "<S-Tab>", ":bp<CR>", { silent = true, desc = "prev tab" })

-- Move Lines
keymap("n", "<A-Down>", ":m .+1<cr>==", { desc = "Move down" })
keymap("n", "<A-Up>", ":m .-2<cr>==", { desc = "Move up" })

-- Split windows
keymap("n", "vs", ":vs<CR>", { silent = true, desc = "split vertically" })
keymap("n", "sp", ":sp<CR>", { silent = true, desc = "split horizontally" })

-- Better marks
keymap("n", "'", "`", { silent = true })

-- Repeat and macro
keymap("n", "`", "@a", { silent = true })

-- Find text in file
keymap("n", "<C-s>", "<cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({}))<CR>", { silent = true, desc = "search" })

-- Copy and paste
keymap("n", "<C-y>", "<esc>:%y+<CR>", { silent = true });

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

keymap("n", "<leader>a", "<cmd>Alpha<CR>", { desc = "Show Alpha" })

-- buffers
keymap("n", "<leader>bb", "<cmd>lua require('telescope.builtin').buffers()<CR>", { desc = "Switcg Buffers" })
keymap("n", "<leader>bd", "<cmd>Bdelete!<CR>", { desc = "Delete current buffer" })

-- cmake
keymap("n", "<leader>cg", "<cmd>CMakeGenerate<CR>", { desc = "Generate" })
keymap("n", "<leader>cx", "<cmd>CMakeGenerate!<CR>", { desc = "Clean and generate" })
keymap("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { desc = "Build" })
keymap("n", "<leader>cr", "<cmd>CMakeRun<CR>", { desc = "Run" })
keymap("n", "<leader>cd", "<cmd>CMakeDebug<CR>", { desc = "Debug" })
keymap("n", "<leader>cy", "<cmd>CMakeSelectBuildType<CR>", { desc = "Select Build Type" })
keymap("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<CR>", { desc = "Select Build Target" })
keymap("n", "<leader>cl", "<cmd>CMakeSelectLaunchTarget<CR>", { desc = "Select Launch Target" })
keymap("n", "<leader>co", "<cmd>CMakeOpen<CR>", { desc = "Open CMake Console" })
keymap("n", "<leader>cc", "<cmd>CMakeClose<CR>", { desc = "Close CMake Console" })
keymap("n", "<leader>ci", "<cmd>CMakeInstall<CR>", { desc = "Intall CMake target" })
keymap("n", "<leader>cn", "<cmd>CMakeClean<CR>", { desc = "Clean CMake target" })
keymap("n", "<leader>cs", "<cmd>CMakeStop<CR>", { desc = "Stop CMake Process" })
keymap("n", "<leader>cp", "<cmd>cd %:p:h<CR> ", { desc = "Change pwd to current file" })

-- find
keymap("n", "<leader>fc", "<cmd>Telescope colorscheme<CR>", { desc = "Colorscheme" })
keymap("n", "<leader>fC", "<cmd>Telescope commands<CR>", { desc = "Commands" })
keymap("n", "<leader>ff",
  [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
  { desc = "Find files" })
keymap("n", "<leader>fF",
  "<cmd>lua require('telescope.builtin').find_files({no_ignore=true})<CR>",
  { desc = "Find files but no ignore" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help" })
keymap("n", "<leader>fl", "<cmd>Telescope resume<CR>", { desc = "Last Search" })
keymap("n", "<leader>fm", "<cmd>Telescope man_pages<CR>", { desc = "Man Pages" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent File" })
keymap("n", "<leader>fR", "<cmd>Telescope registers<CR>", { desc = "Registers" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })
keymap("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Todos" })

-- git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
keymap("n", "<leader>gf", "<cmd>0Gclog<CR>", { desc = "File history" })
keymap("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<CR>", { desc = "Next Hunk" })
keymap("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", { desc = "Prev Hunk" })
keymap("n", "<leader>gL", "<cmd>G blame<CR>", { desc = "Git Blame Information" })
keymap("n", "<leader>gl", "<cmd>Gclog<CR>", { desc = "Git Log Information" })
keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", { desc = "Preview Hunk" })
keymap("n", "<leader>gP", "<cmd>G push<CR>", { desc = "Push..." })
keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", { desc = "Reset Hunk" })
keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", { desc = "Reset Buffer" })
keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", { desc = "Stage Hunk" })
keymap("n", "<leader>gu",
  "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
  { desc = "Undo Stage Hunk" }
)
keymap("n", "<leader>go", "<cmd>Telescope git_status<CR>", { desc = "Open changed file" })
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Checkout branch" })
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Checkout commit" })
keymap("n", "<leader>gd",
  "<cmd>lua require('user.utils.diff')()<CR>",
  { desc = "Diff With" }
)

-- hop
keymap("n", "<leader>hw", "<cmd>HopWordCurrentLine<CR>", { desc = "Hop Word In Current Line" })
keymap("n", "<leader>hp", "<cmd>HopPattern<CR>", { desc = "Hop Word With Pattern" })

-- markdown
keymap("n", "<leader>mP", "<Plug>MarkdownPreview", { desc = "Preview Markdown" })
keymap("n", "<leader>ms", "<Plug>MarkdownPreviewStop", { desc = "Stop Preview Markdown" })
keymap("n", "<leader>mt", "<cmd>InsertToc<CR>", { desc = "Insert Tocs" })
keymap("n", "<leader>mp", "<cmd>PasteImg<CR>", { desc = "Paster Images" })

-- code runner
keymap("n", "<leader>rr", "<cmd>RunFile<CR>", { desc = "Run File" })
keymap("n", "<leader>rp", "<cmd>RunProject<CR>", { desc = "Run Project" })
keymap("n", "<leader>rc", "<cmd>RunClose<CR>", { desc = "Close" })

-- terminal
keymap("n", "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Node" })
keymap("n", "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<CR>", { desc = "NCDU" })
keymap("n", "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<CR>", { desc = "Htop" })
keymap("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Python" })
keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float" })
keymap("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "Horizontal" })
keymap("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "Vertical" })

keymap("n", "<leader>n", "<cmd>noh<CR>", { desc = "Clear highlight" })

---------------------------------- Insert Mode --------------------------

keymap("i", "<A-Down>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
keymap("i", "<A-Up>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })
------------------------------------ Visual Mode ------------------------
-- Stay in indent mode
keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

-- Repeat and macro
keymap("v", ".", ":normal .<CR>", { silent = true })
keymap("v", "`", ":normal @a<CR>", { silent = true })

keymap("v", "p", '"_dP', { silent = true })

-- Move text up and down
keymap("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
---------------------------------- Visual Block Mode ------------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", { silent = true })
keymap("x", "K", ":move '<-2<CR>gv-gv", { silent = true })
keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

---------------------------------- Terminal Mode ---------------------------
-- <C-\>: toggle terminal window
-- Alt+x: exit terminal mode
keymap("t", "<A-x>", [[<C-\><C-n>]], { silent = true })
