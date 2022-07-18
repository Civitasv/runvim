# Keymaps Configuration

There are several files relate to keymaps.

## WhichKey

[WhichKey](https://github.com/folke/which-key.nvim) is a plugin for Neovim that displays a popup with possible key bindings of the command you started typing.

Here I use it for my most keymaps. Inspired by SpaceEmacs and DoomEmacs, I also use `SPACE` as my leader key, in this way I can managed my keymaps in a sane way with this plugin.

See [whichkey.lua](lua/user/whichkey.lua)

```lua
local leader_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
```

## Other keymaps

There're also many key maps configured in [keymaps.lua](lua/user/keymaps.lua). They don't use WhichKey.

## A. Basic

0. Leader Key.

```lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
```

1. I prefer to use `U` than `<C-r>`.

```lua
-- Redo
keymap("n", "U", "<C-r>", opts)
```

2. Move down and up by Visual Line.

```lua
-- Move down and up only one visual line
keymap("n", "j", "gj", opts_silent)
keymap("n", "k", "gk", opts_silent)
```

3. `n`: next result, `zz`: center current line, `zv`: open enough folds to display the cursor position.

```lua
-- Next/Previous search result
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
```

4. I enjoy using `Ctrl+j, k, h, l` to navigate between window.

```lua
-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("t", "<F10>", [[<C-\><C-n>]], opts)
keymap("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
keymap("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
keymap("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
keymap("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
```

5. Window Resize.

```lua
-- Resize
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical :resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical :resize -2<CR>", opts)
```

6. Buffer navigation and deletion.

```lua
-- Buffers navigate
keymap("n", "bj", ":bp<CR>", opts)
keymap("n", "bk", ":bn<CR>", opts)
keymap("n", "<Tab>", ":bn<CR>", opts)
keymap("n", "<S-Tab>", ":bp<CR>", opts)

-- Buffers remove
keymap("n", "bd", ":Bdelete!<CR>", opts)
```

keymap("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", opts)

7. Use `Alt-j, k, down, up` to move text up and down.

```lua
-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-Down>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("n", "<A-Up>", "<Esc>:m .-2<CR>==", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)


-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
```

8. Use `vs` and `sp` to split window.

```lua
-- Split windows
keymap("n", "vs", ":vs<CR>", opts)
keymap("n", "sp", ":sp<CR>", opts)
```

9. I almost only use marks to jump to the cursor rather beginning of the line.

```lua
-- Better marks
keymap("n", "'", "`", opts)
```

10. Repeat Macros.

```lua
-- Repeat and macro
keymap("n", "`", "@a", opts)

-- Repeat and macro
keymap("v", ".", ":normal .<CR>", opts)
keymap("v", "`", ":normal @a<CR>", opts)
```

11. Indent.

```lua
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
```

## B. LaTex

1. `,ll`: compile
2. `,lv`: sync location of pdf reader
3. `Ctrl+Click Pdf`: sync location of neovim
4. `,lk`: stop compile
5. `,lc`: clear compile middle files
6. `[[, ]], [], ][`: move between section boundaries
7. `dsc, dse, ds$, dsd`: Delete the surrounding command, environment or delimiter
8. `csc, cse, cs$, csd`: Change the surrounding command, environment or delimiter
9. `tsc, tse`: Toggle starred command or environment
10. `ts$`: Toggle inline and displaymath
11. `tsd`: Toggle between e.g. () and \left(\right)
12. `tsf`: Toggle (inline) fractions
13. others, see: <https://github.com/lervag/vimtex#configuration>

## C. Terminal

I use [toggleterm](https://github.com/akinsho/toggleterm.nvim) to manage terminals in neovim.

Keymaps in WhichKey:

```lua
t = {
  name = "Terminal",
  n = { "<cmd>lua _NODE_TOGGLE()<CR>", "Node" },
  u = { "<cmd>lua _NCDU_TOGGLE()<CR>", "NCDU" },
  t = { "<cmd>lua _HTOP_TOGGLE()<CR>", "Htop" },
  p = { "<cmd>lua _PYTHON_TOGGLE()<CR>", "Python" },
  f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
  h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
  v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
},
```

## D. Telescope

I like to use `<C-s>` and `<C-f>` to find text and files.

```lua
-- Find text in file
keymap("n", "<C-s>", "<cmd>Telescope live_grep theme=ivy<CR>", opts)

-- Find files
keymap(
  "n",
  "<C-f>",
  "<cmd>lua require('telescope.builtin').find_files()<CR>",
  opts
)
```

Others use WhichKey.

WhichKey:

```lua
f = {
  name = "Find",
  b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
  c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
  f = {
    [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
    "Find files",
  },
  F = {
    "<cmd>lua require('telescope.builtin').find_files({no_ignore=true})<CR>",
    "Find files but no ignore",
  },
  t = { "<cmd>Telescope live_grep theme=ivy<CR>", "Find Text" },
  h = { "<cmd>Telescope help_tags<CR>", "Help" },
  l = { "<cmd>Telescope resume<CR>", "Last Search" },
  M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
  r = { "<cmd>Telescope oldfiles<CR>", "Recent File" },
  R = { "<cmd>Telescope registers<CR>", "Registers" },
  k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
  C = { "<cmd>Telescope commands<CR>", "Commands" },
}
```

### Insert Mode

1. `<C-c>`: close window
2. `<C-p>, <C-n>`: cycle history
3. `<C-j>, <C-k>`: next, previous result
4. `<Down>, <Up>`: next, previous result
5. `<CR>`: select
6. `<C-x>`: select in a new horizontal window
7. `<C-v>`: select in a new vertical window
8. `<C-t>`: select in a new tab
9. `<C-u>`: scroll up
10. `<C-d>`: scroll down
11. `<Tab>`: move to a worse result
12. `<S-Tab>`: move to a better result

### Normal Mode

1. `<esc>, q`: close window
2. `<CR>`: select
3. `<C-x>`: select in a new horizontal window
4. `<C-v>`: select in a new vertical window
5. `<C-t>`: select in a new tab
6. `<Tab>`: move to a worse result
7. `<S-Tab>`: move to a better result
8. `j, k`: next, previous result
9. `<Down>, <Up>`: next, previous result
10. `H`: move to top
11. `M`: move to middle
12. `L`: move to bottom
13. `gg`: move to top
14. `G`: move to bottom
15. `<C-u>`: scroll up
16. `<C-d>`: scroll down

## E. Surround

I use [nvim-surround](https://github.com/kylechui/nvim-surround) to add/change/delete surrounding delimiter pairs.

1. `ys`: to insert delimiter
2. `cs`: to change delimiter
3. `ds`: to delete delimiter

## F. Code folding

I use [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo#commands) to fold code.

1. `za`: toggle fold under cursor
2. `zA`: toggle all folds under cursor
3. `zc`: close fold under cursor
4. `zC`: close all folds under cursor
5. `zM`: close all folds
6. `zo`: open fold under cursor
7. `zO`: open all folds under cursor
8. `zR`: open all folds

You can see all of them in WhichKey popup after click `z`.

## G. File Explorer Tree

I use [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua) to show file explorer.

1. `<C-n>`: Toggle visibility of nvim-tree(normal mode).

## H. Markdown

I use [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) to preview markdown in browser.

WhichKey:

```lua
m = {
  name = "Markdown",
  p = { "<Plug>MarkdownPreview", "Preview Markdown" },
  s = { "<Plug>MarkdownPreviewStop", "Stop Preview Markdown" }
}
```

## I. Hop

I use [hop.nvim](https://github.com/phaazon/hop.nvim) to jump anywhere in a document with few keystrokes.

I only remap `HopWordCurrentLine` and `HopPattern`.

WhichKey:

```lua
h = {
  name = "Hop",
  w = { "<cmd>HopWordCurrentLine<CR>", "Hop Word In Current Line" },
  p = { "<cmd>HopPattern<CR>", "Hop Word With Pattern" },
}
```

## J. Comment

I use [Comment.nvim](https://github.com/numToStr/Comment.nvim) to comment.

See [Usage](https://github.com/numToStr/Comment.nvim#-usage) for keymaps.

## K. Code Runner

I use [code_runner.nvim](https://github.com/CRAG666/code_runner.nvim) to run code.

WhichKey:

```lua
r = {
  name = "Code Runner",
  r = { "<cmd>RunFile<CR>", "Run File" },
  p = { "<cmd>RunProject<CR>", "Run Project" },
  c = { "<cmd>RunClose<CR>", "Close" }
},
```

## L. Completion

I use [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) to complete codes in neovim.

1. `<Tab>, <C-j>`: next
2. `<S-Tab>, <C-k>`: previous
3. `<CR>`: select

## M. CMake

I use [cmake-tools.nvim](https://github.com/Civitasv/cmake-tools.nvim) to integrate CMake in neovim.

WhichKey:

```lua
c = {
  -- Typical cmake workflow:
  -- 1. CMake configure (only once)
  -- 2. CMake selec_target (ususally once)
  -- 3. CMake build (once change, build it)
  name = "CMake",
  g = { "<cmd>CMakeGenerate<CR>", "Generate" },
  x = { "<cmd>CMakeGenerate!<CR>", "Clean and Generate" },
  b = { "<cmd>CMakeBuild<CR>", "Build" },
  r = { "<cmd>CMakeRun<CR>", "Run" },
  d = { "<cmd>CMakeDebug<CR>", "Debug" },
  y = { "<cmd>CMakeSelectBuildType<CR>", "Select Build Type" },
  t = { "<cmd>CMakeSelectBuildTarget<CR>", "Select Build Target" },
  l = { "<cmd>CMakeSelectLaunchTarget<CR>", "Select Launch Target" },
  o = { "<cmd>CMakeOpen<CR>", "Open CMake Console" },
  c = { "<cmd>CMakeClose<CR>", "Close CMake Console" },
  i = { "<cmd>CMakeInstall<CR>", "Intall CMake target" },
  n = { "<cmd>CMakeClean<CR>", "Clean CMake target" },
  s = { "<cmd>CMakeStop<CR>", "Stop CMake Process" },
}
```

## N. Lsp

### Basic

1. `gD`: find declaration
2. `gd`: find definition
3. `gi`: find implementation
4. `gr`: find references
5. `K`: show documention
6. `<C-k>`: show signature help
7. `ca`: show code action
8. `]d, [d`: next, previous diagnostic info

WhichKey:

```lua
l = {
  name = "LSP",
  a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
  d = {
    "<cmd>Telescope lsp_document_diagnostics<CR>",
    "Document Diagnostics",
  },
  w = {
    "<cmd>Telescope lsp_workspace_diagnostics<CR>",
    "Workspace Diagnostics",
  },
  f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
  i = { "<cmd>LspInfo<CR>", "Info" },
  I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
  j = {
    "<cmd>lua vim.diagnostic.goto_next()<CR>",
    "Next Diagnostic",
  },
  k = {
    "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    "Prev Diagnostic",
  },
  l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
  q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
  s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
  S = {
    "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
    "Workspace Symbols",
  },
}
```

### Rust

Rust have different behaviour of `K` which is defined by [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim).

WhichKey:

```lua
s = {
  name = "Rust Tools",
  r = { "<cmd>RustRunnables<CR>", "Runnables List" },
  d = { "<cmd>RustDebuggables<CR>", "Debuggables List" },
  e = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
  j = { "<cmd>RustMoveItemDown<CR>", "Move Item Down" },
  k = { "<cmd>RustMoveItemUp<CR>", "Move Item Up" },
  K = { "<cmd>lua ShowDocumentation()<CR>", "Hover Me" },
  R = { "<cmd>RustHoverRange<CR>", "Hover Range Me" },
  o = { "<cmd>RustOpenCargo<CR>", "Open Cargo" },
  l = { "<cmd>RustJoinLines<CR>", "Join Lines" },
  v = { "<cmd>lua require('crates').show_versions_popup()<CR>", "Show Versions Popup" },
  f = { "<cmd>lua require('crates').show_features_popup()<CR>", "Show Features Popup" },
  D = { "<cmd>lua require('crates').show_dependencies_popup()<CR>", "Show Dependencies Popup" },
  u = { "<cmd>lua require('crates').update_crate()<CR>", "Update Crate" },
  U = { "<cmd>lua require('crates').update_all_crates()<CR>", "Update All Crates" },
  p = { "<cmd>lua require('crates').upgrade_crate()<CR>", "Upgrade Crate" },
  P = { "<cmd>lua require('crates').upgrade_all_crates()<CR>", "Upgrade All Crates" },
  h = { "<cmd>lua require('crates').open_homepage()<CR>", "Open Homepage" },
  n = { '<cmd>lua require("renamer").rename()<CR>', "Rename" }
},
```

## O. Debug

I use [nvim-dap](https://github.com/mfussenegger/nvim-dap) to debug in neovim.

```lua
-- Debug
keymap("n", "<F5>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<F6>", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F7>", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F8>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F9>", "<cmd>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.disconnect()<CR>", opts)

keymap("i", "<F5>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("i", "<F6>", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("i", "<F7>", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("i", "<F8>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("i", "<F9>", "<cmd>lua require'dap'.step_out()<CR>", opts)
keymap("i", "<F10>", "<cmd>lua require'dap'.disconnect()<CR>", opts)

-- WhichKey:
d = {
  name = "Debug",
  t = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
  b = { "<cmd>lua require'dap'.step_back()<CR>", "Step Back" },
  c = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
  C = { "<cmd>lua require'dap'.run_to_cursor()<CR>", "Run To Cursor" },
  d = { "<cmd>lua require'dap'.disconnect()<CR>", "Disconnect" },
  g = { "<cmd>lua require'dap'.session()<CR>", "Get Session" },
  i = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
  o = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
  u = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },
  p = { "<cmd>lua require'dap'.pause.toggle()<CR>", "Pause" },
  r = { "<cmd>lua require'dap'.repl.toggle()<CR>", "Toggle Repl" },
  s = { "<cmd>lua require'dap'.continue()<CR>", "Start" },
  q = { "<cmd>lua require'dap'.close()<CR>", "Quit" },
  l = { "<cmd>lua require'osv'.run_this()<CR>", "Debug Lua" },
}
```

## P. Git

1. Basic Blame information: gitsigns
2. Complex Blame information: vim-fugitive
3. Stage, Commit, Push: vim-fugitive
4. Or, Another Beautiful Git integration: lazygit & toggleterm

### Diffview

1. file history for current version: `SPC g f`
2. diffview for current version: `SPC g d`, with ui select
3. diffview for older version: `SPC g d`, with ui input

WhichKey:

```lua
g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    f = { "<cmd>0Gclog<CR>", "File history" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
    L = { "<cmd>G blame<CR>", "Git Blame Information" },
    l = { "<cmd>Gclog<CR>", "Git Log Information" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
    P = { "<cmd>G push<CR>", "Push..." },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
    d = {
      "<cmd>lua require('user.utils.diff')()<CR>",
      "Diff With",
    },
}
```
