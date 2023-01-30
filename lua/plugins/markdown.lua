return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  ft = { "markdown" },
  dependencies = {
    {
      "iamcco/markdown-preview.nvim",
      build = "cd app && npm install",
      ft = { "markdown" },
    },
    "godlygeek/tabular",
    "preservim/vim-markdown",
  },
  config = function()
    vim.cmd([[
      let g:mkdp_theme = 'light'
      let g:mkdp_auto_start=0
      let g:mkdp_auto_close=0
      let g:mkdp_refresh_slow=0

      let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']
      let g:vim_markdown_no_default_key_mappings = 1
      let g:vim_markdown_folding_disabled = 0
      let g:vim_markdown_frontmatter = 1
      let g:vim_markdown_folding_style_pythonic = 1 
    ]])

    vim.keymap.set("n", "<leader>mj", "<Plug>Markdown_MoveToNextHeader<CR>", { desc = "go to next header" })
    vim.keymap.set("n", "<leader>mk", "<Plug>Markdown_MoveToPreviousHeader<CR>", { desc = "go to previous header" })
    vim.keymap.set("n", "<leader>mc", "<Plug>Markdown_MoveToCurHeader<CR>", { desc = "go to previous header" })
  end
}
