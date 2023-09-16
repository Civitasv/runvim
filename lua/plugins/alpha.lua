return {
  "goolord/alpha-nvim", -- A fast and fully customizable greeter for neovim
  config = function()
    local alpha = require("alpha")

    local startify = require("alpha.themes.startify")

    startify.section.header.val = {
      [[ ┏━━━┓━━━━━━━━━━━━━━━━━━ ]],
      [[ ┃┏━┓┃━━━━━━━━━━━━━━━━━━ ]],
      [[ ┃┗━┛┃┏┓┏┓┏━┓━┏┓┏┓┏┓┏┓┏┓ ]],
      [[ ┃┏┓┏┛┃┃┃┃┃┏┓┓┃┗┛┃┣┫┃┗┛┃ ]],
      [[ ┃┃┃┗┓┃┗┛┃┃┃┃┃┗┓┏┛┃┃┃┃┃┃ ]],
      [[ ┗┛┗━┛┗━━┛┗┛┗┛━┗┛━┗┛┗┻┻┛ ]],
      [[ ━━━━━━━━━━━━━━━━━━━━━━━ ]],
      [[ ━━━━━━━━━━━━━━━━━━━━━━━ ]]
    }
    startify.section.top_buttons.val = {
      startify.button("f", "  Find file", ":Telescope find_files <CR>"),
      startify.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    }

    alpha.setup(startify.config)
  end
}
