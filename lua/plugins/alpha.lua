return {
  "goolord/alpha-nvim", -- A fast and fully customizable greeter for neovim
  config = function()
    local alpha = require("alpha")

    local is_unix = vim.fn.has("unix") == 1
    local is_win32 = vim.fn.has("win32") == 1
    local configure_path
    if is_unix then
      configure_path = "~/.config/nvim/init.lua"
    elseif is_win32 then
      configure_path = "~/AppData/Local/nvim/init.lua"
    end

    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
        [[ ┏━━━┓━━━━━━━━━━━━━━━━━━ ]],
        [[ ┃┏━┓┃━━━━━━━━━━━━━━━━━━ ]],
        [[ ┃┗━┛┃┏┓┏┓┏━┓━┏┓┏┓┏┓┏┓┏┓ ]],
        [[ ┃┏┓┏┛┃┃┃┃┃┏┓┓┃┗┛┃┣┫┃┗┛┃ ]],
        [[ ┃┃┃┗┓┃┗┛┃┃┃┃┃┗┓┏┛┃┃┃┃┃┃ ]],
        [[ ┗┛┗━┛┗━━┛┗┛┗┛━┗┛━┗┛┗┻┻┛ ]],
        [[ ━━━━━━━━━━━━━━━━━━━━━━━ ]],
        [[ ━━━━━━━━━━━━━━━━━━━━━━━ ]]
    }
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
      dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", "  Configuration", ":e" .. configure_path .. "<CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.opts.opts.noautocmd = true

    alpha.setup(dashboard.opts)
  end
}
