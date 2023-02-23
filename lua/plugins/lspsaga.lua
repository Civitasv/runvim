return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  config = function()
    require("lspsaga").setup({
      preview = {
        lines_above = 0,
        lines_below = 10,
      },
      scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
      },
      request_timeout = 2000,
      finder = {
        --percentage
        max_height = 0.5,
        keys = {
          jump_to = "p",
          edit = { "o", "<CR>" },
          vsplit = "s",
          split = "i",
          tabe = "t",
          tabnew = "r",
          quit = { "q", "<ESC>" },
          close_in_preview = "<ESC>"
        },
      },
      definition = {
        edit = "<C-c>o",
        vsplit = "<C-c>v",
        split = "<C-c>i",
        tabe = "<C-c>t",
        quit = "q",
        close = "<Esc>",
      },
      code_action = {
        num_shortcut = true,
        show_server_name = false,
        extend_gitsigns = true,
        keys = {
          -- string | table type
          quit = "<ESC>",
          exec = "<CR>",
        },
      },
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = false,
        sign_priority = 40,
        virtual_text = false,
      },
      diagnostic = {
        show_code_action = true,
        show_source = true,
        jump_num_shortcut = true,
        --1 is max
        max_width = 0.7,
        custom_fix = nil,
        custom_msg = nil,
        text_hl_follow = false,
        border_follow = true,
        keys = {
          exec_action = "o",
          quit = "q",
          go_action = "g"
        },
      },
      rename = {
        quit = "<C-c>",
        exec = "<CR>",
        mark = "x",
        confirm = "<CR>",
        in_select = true,
      },
      outline = {
        win_position = "right",
        win_with = "",
        win_width = 30,
        show_detail = true,
        auto_preview = true,
        auto_refresh = true,
        auto_close = true,
        custom_sort = nil,
        keys = {
          jump = "o",
          expand_collapse = "u",
          quit = "q",
        },
      },
      symbol_in_winbar = {
        enable = true,
        separator = " - ",
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        respect_root = false,
        color_mode = true,
      },
    })
  end,
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    --Please make sure you install markdown and markdown_inline parser
    { "nvim-treesitter/nvim-treesitter" }
  }
}
