return {
  {
    "iamcco/markdown-preview.nvim",
    dependencies = {
    },
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.cmd([[
      let g:mkdp_auto_start=0
      let g:mkdp_auto_close=0
      let g:mkdp_refresh_slow=0
      let g:mkdp_markdown_css = expand("~/.config/nvim/markdown/github-markdown.css")
    ]])
    end
  },
  {
    dir = "~/.local/share/nvim/personal/mdp.nvim",
    config = function()
      require("mdp").setup(
        {
          pdfviewer = "Skim",
          template = "lecture"
        }
      )
    end
  }
}
