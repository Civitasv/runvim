--[[ require("github-theme").setup( ]]
--[[   { ]]
--[[     theme_style = "light", ]]
--[[     -- function_style = "italic", ]]
--[[     comment_style = "italic", ]]
--[[     -- keyword_style = "italic", ]]
--[[     -- variable_style = "italic", ]]
--[[     dark_sidebar = "false" ]]
--[[   } ]]
--[[ ) ]]
local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
  return
end

catppuccin.setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  term_colors = true,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = false,
    mason = true,
    which_key = true
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
