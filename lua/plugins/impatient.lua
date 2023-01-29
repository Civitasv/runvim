return {
  "lewis6991/impatient.nvim", -- Speed up loading Lua modules in neovim to improve startup time
  config = function()
    local impatient = require("impatient")

    impatient.enable_profile()
  end
}
