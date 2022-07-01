-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_italic_comments = true
-- vim.g.tokyonight_italic_keywords = true
--
-- vim.cmd [[
-- try
-- " set background=dark
-- " colorscheme github_dark
-- catch /^Vim\%((\a\+)\)\=:E185/
-- colorscheme default
-- set background=dark
-- endtry
-- ]]

require("catppuccin").setup(
  {
    transparent_background = false,
    term_colors = false,
    styles = {
      comments = "italic",
      functions = "italic",
      keywords = "italic",
      strings = "NONE",
      variables = "italic",
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = "italic",
          hints = "italic",
          warnings = "italic",
          information = "italic",
        },
        underlines = {
          errors = "underline",
          hints = "underline",
          warnings = "underline",
          information = "underline",
        },
      },
      lsp_trouble = false,
      cmp = true,
      lsp_saga = false,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = false,
        transparent_panel = false,
      },
      neotree = {
        enabled = false,
        show_root = false,
        transparent_panel = false,
      },
      which_key = false,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      dashboard = true,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = false,
      hop = false,
      notify = true,
      telekasten = true,
      symbols_outline = true,
    }
  }
)

require("nightfox").setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
})

require("github-theme").setup(
  {
    theme_style = "dark",
    function_style = "italic",
    comment_style = "italic",
    keyword_style = "italic",
    variable_style = "italic",
  }
)
