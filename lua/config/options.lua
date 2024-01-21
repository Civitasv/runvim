local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  autoread = true, -- when file changed, autoread it
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  incsearch = true, -- enable incsearch
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0, -- don't show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  -- if a file is being edited by another program
  -- (or was written to file while editing with another program), it is not allowed to be edited
  writebackup = false,
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 3, -- set number column width to 2 {default 4}
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  errorbells = false, -- no error bells
  title = true, -- show title in terminal header
  fillchars = {
    diff = "",
    fold = " ",
    eob = " ",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
    foldclose = "",
    foldopen = "",
    foldsep = " ",
  },
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

--[[ if vim.fn.has("nvim-0.9") == 1 and not vim.opt.diff:get() then ]]
--[[   vim.opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s%C" ]]
--[[ end ]]

if vim.fn.has("nvim-0.9") == 1 and not vim.opt.diff:get() then
  vim.opt.signcolumn = "yes:1"
elseif vim.fn.has("nvim-0.9") == 0 then
  vim.opt.signcolumn = "number"
end

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess = "filnxtToOFWIcC"
end
