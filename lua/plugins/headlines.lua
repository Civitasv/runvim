return {
  -- Make markdown header beautiful.
  "lukas-reineke/headlines.nvim",
  lazy = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    local highlight = function(group, options)
      local guifg = options.fg or "NONE"
      local guibg = options.bg or "NONE"
      local guisp = options.sp or "NONE"
      local gui = options.gui or "NONE"
      local blend = options.blend or 0
      local ctermfg = options.ctermfg or "NONE"

      vim.cmd(
        string.format(
          "highlight %s guifg=%s ctermfg=%s guibg=%s guisp=%s gui=%s blend=%d",
          group,
          guifg,
          ctermfg,
          guibg,
          guisp,
          gui,
          blend
        )
      )
    end

    -- markdown
    highlight("CodeBlock", { bg = "#1c1c1c" })
    highlight("HeadlineGreen", { bg = "#1e2718" })
    highlight("HeadlineBlue", { bg = "#21262d" })
    highlight("HeadlineRed", { bg = "#2c1517" })
    highlight("HeadlinePurple", { bg = "#27182C" })
    highlight("HeadlineYellow", { bg = "#3e2e1e" })
    highlight("Quote", { fg = "#D19A66", bg = "#3B4048" })

    require("headlines").setup {
      markdown = {
        query = vim.treesitter.parse_query(
          "markdown",
          [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
        ),
        headline_highlights = {
          "HeadlineGreen",
          "HeadlineBlue",
          "HeadlineRed",
          "HeadlinePurple",
          "HeadlineYellow",
        },
        codeblock_highlight = "",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "🬂",
      },
      rmd = {
        query = vim.treesitter.parse_query(
          "markdown",
          [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
        ),
        treesitter_language = "markdown",
        headline_highlights = { "Headline" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "🬂",
      },
    }
  end
}
