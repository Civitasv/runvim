return {
  "bluz71/vim-nightfly-colors",
  config = function()
    -- nightfly
    vim.g.nightflyWinSeparator = 2
    vim.g.nightflyNormalFloat = true
    vim.g.nightflyCursorColor = true
    vim.cmd.colorscheme "nightfly"
  end
}
