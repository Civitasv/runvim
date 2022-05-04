-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_italic_comments=false
-- vim.g.tokyonight_italic_keywords=false

vim.cmd [[
try
colorscheme tokyonight
set background=dark
" colorscheme everforest
catch /^Vim\%((\a\+)\)\=:E185/
colorscheme default
set background=dark
endtry
]]
