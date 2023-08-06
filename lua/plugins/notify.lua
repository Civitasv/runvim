return {
  "rcarriga/nvim-notify", -- tree view
  config = function()
    require("notify").setup({
      background_colour = "#000000",
    })
  end
}
